module JsonResourceActions
  extend ActiveSupport::Concern

  included do
    respond_to :json
  end

  def index
    @resources = resources
      .order(created_at: :desc)
      .limit(params[:limit] || 10)
      .offset(params[:offset] || 0)
    render json: @resources.as_json
  end

  def create
    @resource = resources.create(resource_params)
    if @resource.persisted?
      render json: @resourse.as_json
    else
      render json: @resourse.errors.as_json, status: 422
    end
  end

  def update
    @resource = find_resource
    @resource.update(resource_params)
    if @resource.valid?
      render json: @resource.as_json
    else
      render json: @resource.errors.as_json, status: 422
    end
  end

  def destroy
    @resource = find_resource
    @resource.destroy
    render json: @resource.as_json
  end

  def find_resource
    resources.find(params[:id])
  end

  def resources
    raise '#resource not implemented'
  end

  def resource_params
    raise '#resource_params not implemented'
  end
end
