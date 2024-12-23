import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";

export default class extends Controller {
  static targets = ["input", "progress"];

  uploadFile() {
    Array.from(this.inputTarget.files).forEach((file) => {
      const upload = new DirectUpload(
        file,
        this.inputTarget.dataset.directUploadUrl,
        this // callback directUploadWillStoreFileWithXHR(request)
      );

      upload.create((error, blob) => {
        if (error) {
          console.log(error);
        } else {
          this.createHiddenBlobInput(blob);
        }
      });
    });
  }

  // add blob id to be submitted with the form
  createHiddenBlobInput(blob) {
    const hiddenField = document.createElement("input");

    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("value", blob.signed_id);
    hiddenField.name = this.inputTarget.name;

    this.element.appendChild(hiddenField);
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => {
      this.directUploadDidProgress(event);
    });
  }

  directUploadDidProgress(event) {
    const progress = (event.loaded / event.total) * 100;

    this.progressTarget.querySelector("#progress-bar").style.width = `${progress}%`;
    this.progressTarget.querySelector("#progress-bar").innerHTML = `${Math.round(progress)}%`;
  }
}
