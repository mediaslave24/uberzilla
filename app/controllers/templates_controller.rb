class TemplatesController < ApplicationController
  def index
    render "templates/#{params[:template] || 'index'}",
      layout: params[:template].nil? && 'application'
  end
end
