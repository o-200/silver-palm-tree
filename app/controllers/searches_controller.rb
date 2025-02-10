class SearchesController < ApplicationController
  allow_unauthenticated_access
  before_action :set_entity_const

  def search
    if params[:title_search].present?
      @matched_entities = @entity_const.where("title LIKE ?", "%#{params[:title_search]}%")
    else
      @matched_entities = []
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results",
                              partial: "searches/results",
                              locals: { matched_entities: @matched_entities })
      end
    end
  end

  private

  def set_entity_const
    @entity_const = [ Podcast ].find { |c| params[:entity_name] == c.to_s.downcase }
  end
end