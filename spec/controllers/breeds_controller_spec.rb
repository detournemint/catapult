require 'rails_helper'

RSpec.describe BreedsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Breed. As you add validations to Breed, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: 'Mane Coon',
      breed_tags_attributes: [
        {tag_id: 1}
      ]
    }
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BreedsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    tag = Tag.find_or_create_by(name: 'affectionate')
  end

  describe "GET #index" do
    it "returns a success response" do
      breed = Breed.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(JSON.parse(response.body).first["name"]).to eq 'Mane Coon'
      expect(response).to be_success
    end
  end

  describe "GET #breed_tags" do
    it "returns the tags attached to a breed" do
      breed = Breed.create! valid_attributes
      get :breed_tags, params: {breed_id: breed.id}, session: valid_session
      expect(JSON.parse(response.body).first["name"]).to eq 'affectionate'
      expect(response).to be_success
    end
  end

  describe "POST #update_breed_tags" do
    let(:new_attributes) {
      { name: 'Mane Coon',
        breed_tags_attributes: [
          {tag_id: Tag.last.id}
        ]
      }
    }
    
    it "replaces the tags for a breed" do
      Tag.create(name: 'soft')
      breed = Breed.create! valid_attributes
      put :update_breed_tags, params: {breed_id: breed.id, breed: new_attributes}, session: valid_session
      breed.reload
      expect(breed.tags.first.name).to eq 'soft'
      expect(breed.tags.count).to eq 1
    end
  end

  describe "GET #show" do
    it "returns a breed with tags" do
      breed = Breed.create! valid_attributes
      get :show, params: {id: breed.to_param}, session: valid_session
      expect(JSON.parse(response.body)["name"]).to eq 'Mane Coon'
      expect(JSON.parse(response.body)["tags"].first["name"]).to eq 'affectionate'
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Breed" do
        expect {
          post :create, params: {breed: valid_attributes}, session: valid_session
        }.to change(Breed, :count).by(1)
      end

      it "renders a JSON response with the new breed" do

        post :create, params: {breed: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(breed_url(Breed.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new breed" do

        post :create, params: {breed: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Mane Coon',
          breed_tags_attributes: [
            {tag_id: Tag.last.id}
          ]
        }
      }

      it "updates the requested breed" do
        Tag.create(name: 'soft')
        breed = Breed.create! valid_attributes
        put :update, params: {id: breed.to_param, breed: new_attributes}, session: valid_session
        breed.reload
        expect(breed.tags.first.name).to eq 'soft'
        expect(breed.tags.count).to eq 1
      end

      it "renders a JSON response with the breed" do
        breed = Breed.create! valid_attributes

        put :update, params: {id: breed.to_param, breed: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the breed" do
        breed = Breed.create! valid_attributes

        put :update, params: {id: breed.to_param, breed: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested breed" do
      breed = Breed.create! valid_attributes
      expect {
        delete :destroy, params: {id: breed.to_param}, session: valid_session
      }.to change(Breed, :count).by(-1)
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


    it 'renders the tag stats for each breed' do 
      breed = Breed.create! params1
      breed = Breed.create! params2
      breed = Breed.create! params3
      get :stats
      expect(JSON.parse(response.body).first['name']).to eq 'Mane Coon'
    end
  end

end
