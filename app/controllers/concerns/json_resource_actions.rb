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
    respond_with @resources
  end

  def create
    @resource = resources.create(resource_params)
    respond_with @resource
  end

  def update
    @resource = find_resource
    @resource.update(resource_params)
    respond_with @resource
  end

  def destroy
    @resource = find_resource
    @resource.destroy
    respond_with @resource
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
