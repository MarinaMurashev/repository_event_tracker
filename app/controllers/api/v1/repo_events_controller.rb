class Api::V1::RepoEventsController < ApplicationController
  def index
    if params_valid?
      @events = EventFetchers::Github.fetch(
        user: params[:user],
        repo_name: params[:repo_name],
        event_type: params[:event_type],
    )
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  private

  def params_valid?
    return false unless params[:user].present? && params[:repo_name].present?

    return true if params[:event_type].blank?

    EventTypes::GithubPolicy.valid?(params[:event_type])
  end
end
