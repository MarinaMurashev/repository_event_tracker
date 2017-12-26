class HomeController < ApplicationController
  def index
    @default_user = "shopify"
    @default_repo_name = "liquid"
  end
end
