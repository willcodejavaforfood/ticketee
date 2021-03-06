require 'spec_helper'
require 'factory_girl'

Factory.find_definitions

describe TicketsController do
  let(:user) {create_user!}
  let(:project) {Factory(:project)}
  let(:ticket) {Factory(:ticket, :project => project)}

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(:user, user)
      get :show, :id => ticket.id, :project_id => project.id
      response.should redirect_to(root_path)
      flash[:alert].should eql("The project you were looking for could not be found.")
    end
  end

  context "with permission to view the project" do
    before do
      sign_in(:user, user)
      Permission.create(:user => user, :object => project, :action => "view")
    end

    def cannot_create_tickets!
      response.should redirect_to(project)
      flash[:alert].should eql("You cannot create tickets on this project.")
    end

    it "cannot beging to create a ticket" do
      get :new, :project_id => project.id
      cannot_create_tickets!
    end

    it "cannot create a ticket without permission" do
      post :create, :project_id => project.id
      cannot_create_tickets!
    end
  end
end
