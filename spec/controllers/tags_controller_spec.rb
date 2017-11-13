require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Tag. As you add validations to Tag, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'loud'}
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TagsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      tag = Tag.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tag = Tag.create! valid_attributes
      get :show, params: {id: tag.to_param}, session: valid_session
      expect(JSON.parse(response.body)['name']).to eq 'loud'
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, params: {tag: valid_attributes}, session: valid_session
        }.to change(Tag, :count).by(1)
      end

      it "renders a JSON response with the new tag" do

        post :create, params: {tag: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(tag_url(Tag.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new tag" do

        post :create, params: {tag: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'quiet'}
      }

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: new_attributes}, session: valid_session
        tag.reload
        expect(tag.name).to eq 'quiet'
      end

      it "renders a JSON response with the tag" do
        tag = Tag.create! valid_attributes

        put :update, params: {id: tag.to_param, tag: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the tag" do
        tag = Tag.create! valid_attributes

        put :update, params: {id: tag.to_param, tag: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tag" do
      tag = Tag.create! valid_attributes
      expect {
        delete :destroy, params: {id: tag.to_param}, session: valid_session
      }.to change(Tag, :count).by(-1)
    end
  end

  describe "GET #stats" do
    tag1 = Tag.create(name: 'affectionate')
    tag2 = Tag.create(name: 'good hunter')
    tag3 = Tag.create(name: 'always hungry')
    tag4 = Tag.create(name: 'long hair')
    tag5 = Tag.create(name: 'short hair')
    params1 = { name: 'Mane Coon',
                breed_tags_attributes: [
                  {tag_id: tag1.id},
                  {tag_id: tag2.id},
                  {tag_id: tag4.id}
                ]
              }
    params2 = { name: 'Prussian Blue',
                breed_tags_attributes: [
                  {tag_id: tag1.id},
                  {tag_id: tag5.id},
                  {tag_id: tag3.id}
                ]
              }
    params3 = { name: 'tabby',
                breed_tags_attributes: [
                  {tag_id: tag1.id},
                  {tag_id: tag2.id},
                  {tag_id: tag3.id}
                ]
              }

    it 'renders the breed stats for each breed' do 
      breed = Breed.create! params1
      breed = Breed.create! params2
      breed = Breed.create! params3
      get :stats
      expect(JSON.parse(response.body).first['name']).to eq 'affectionate'
    end
  end

end
