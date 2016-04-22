require "spec_helper"

RSpec.describe CompaniesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the companies into @companies" do
      company1, company2 = FactoryGirl.create(:company), FactoryGirl.create(:company)
      get :index
      expect(assigns(:companies)).to match_array([company1, company2])
    end
  end

  describe "GET #show" do
    it "renders json" do
      company1 = FactoryGirl.create(:company)

      get :show, format: :json, id: company1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end