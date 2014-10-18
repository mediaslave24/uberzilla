class TemplatesController < ApplicationController
  def index
    render "templates/#{params[:template] || 'index'}"
  end
end
