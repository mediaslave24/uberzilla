RSpec.shared_examples 'json resource' do
  let :virtual_attributes do
    [:password]
  end

  context 'GET index' do
    before do
      resource_name.singularize.camelize.constantize.destroy_all
    end

    let! :resources do
      create_list resource_name.singularize, 5
    end

    it 'returns list of resources on success' do
      get :index, format: :json
      expect(assigns(:resources).to_a).to eq(resources.sort_by(&:created_at).to_a)
    end
  end

  context 'POST create' do
    it 'creates new resource on success' do
      expect {
        post :create,
          resource_name.singularize.to_sym => resource_params,
          format: :json
      }.to change(resource_name.singularize.camelize.constantize, :count).by(1)
      expect(response).to be_successful
    end
  end

  context 'PUT update' do
    let! :resource do
      create resource_name.singularize
    end

    it 'updates existing resource' do
      put :update,
        resource_name.singularize.to_sym => resource_params,
        format: :json,
        id: resource.to_param

      attributes = resource_params
        .tap { |p| p.extract!(*virtual_attributes) }
        .stringify_keys
      expect(resource.reload.attributes).to include(attributes)
    end
  end

  context 'DELETE destroy' do
    let! :resource do
      create resource_name.singularize
    end

    it 'destroys existing resource' do
      expect {
        delete :destroy,
          format: :json,
          id: resource.to_param
      }.to change {
        resource_name
          .singularize
          .camelize
          .constantize
          .where(id: resource.id)
          .any?
      }.from(true).to(false)
    end
  end
end
