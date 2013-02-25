require "spec_helper"
# db:test:prepare before!
# Thanks to a blog post, this method simulate the file_field
# http://mewttt.blogspot.de/2011/04/simulating-filefield-in-rspec.html
def mock_file(name)
  file = File.new("#{Rails.root}/spec/fixtures/files/" + name,"r")
  vfile = ActionDispatch::Http::UploadedFile.new(
          :filename => name,
          :type => "application/pdf",
          :head => "Content-Disposition: form-data;
                    name=\"bill\"; 
                    filename=\"" + name + "\" 
                    Content-Type: application/pdf\r\n",
          :tempfile => file)
  return vfile
end 

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
    			post :create, :debt => {:value => 1,:description => "test1",:debitor_id => 1,:creditor_id => 2,:bill => mock_file('test_valid.pdf')}
			response.should redirect_to Debt.last
		end
            end

	    context 'without a file' do
		it "creates a new debt without a bill" do
			post :create, :debt => {:value => 2,:description => "test2",:debitor_id => 1,:creditor_id => 2}
			response.should redirect_to Debt.last
		end
	    end

	    context 'with invalid file ' do
		it "creates a new debt with invalid bill" do
			post :create, :debt => {:value => 3,:description => "test3",:debitor_id => 1,:creditor_id => 2,:bill => mock_file('test_invalid.pdf')}
			#response.should redirect_to Debt.last -> failed
			#response.should_not redirect_to Debt.last -> passed
			response.should render_template("new") 
		end
	    end
	
	describe 'Debt #show' do
		it 'calculate dollar value' do
			@debt = Debt.create(value: '10', description: 'testdata', debitor_id: '2', creditor_id: '3')
			Exchange.create(name: "USD", value: 2.0)
			Exchange.create(name: "JPY", value: 124)
			Exchange.create(name: "GBP", value: 0.8)
			Exchange.create(name: "RUB", value: 40)
			Exchange.create(name: "BIT", value: 24)
 			get :show, id:1
			assigns(:dollar).should == 20 
		end
	end
	end
end
