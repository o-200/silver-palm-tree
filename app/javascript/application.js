// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import "controllers";
import "bootstrap";
import "@popperjs/core";

// implementation of full redirecting using turbo_stream
// turbo_stream.action(:redirect, root_path)
Turbo.StreamActions.redirect = function() {
  Turbo.visit(this.target)
}
