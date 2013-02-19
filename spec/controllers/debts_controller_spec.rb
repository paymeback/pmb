require "spec_helper"
# db:test:prepare before!

describe DebtsController do
	Debt.delete_all
	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:user]
		@user1 = User.create(id: 1 , email:"u1@pmb.dev",password:"test12",password_confirmation:"test12",nickname:"u1")
		@user2 = User.create(id: 2,email:"u2@pmb.dev",password:"test12",password_confirmation:"test12",nickname:"u2")
		sign_in User.last
	end

	#not necessary, but just to test if sign_up is working
	it "should have a current_user" do
    	   	subject.current_user.should_not be_nil
  	end	

	#test for creating debts in serveral ways
	describe "POST #create" do

	    context 'with a valid file' do
		it "creates a new debt with valid bill" do
    			post :create, :debt => {}#insert code here
			response.should redirect_to Debt.last
		end
            end

	    context 'without a file' do
		it "creates a new debt without a bill" do
			post :create, :debt => {}#insert code here
			response.should redirect_to Debt.last
		end
	    end

	    context 'with invalid file ' do
		it "creates a new debt with invalid bill" do
			post :create, :debt => {}#insert code here
			#response.should redirect_to Debt.last -> failed
			#response.should_not redirect_to Debt.last -> passed
			response.should render_template("new") 
		end
	    end
	end
end
