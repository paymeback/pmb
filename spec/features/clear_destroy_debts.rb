require "spec_helper"

describe 'clear debt process',:js => true do
		
		before(:all) do
			Debt.delete_all
			Exchange.delete_all
			Exchange.create(name: "USD", value: 3.3)
			Exchange.create(name: "JPY", value: 124)
			Exchange.create(name: "GBP", value: 0.8)
			Exchange.create(name: "RUB", value: 40)
			Exchange.create(name: "BIT", value: 25)
			@debt = Debt.create(value:"5.5",description:"test",creditor_id:1,debitor_id:2)
			User.create(email: "u1@pmb.dev", password:"test12",password_confirmation: "test12",nickname:"u1")
			User.create(email: "u2@pmb.dev", password:"test12",password_confirmation: "test12",nickname:"u2")
		end

		it 'clear and then destroy the debt' do
			#log in
			visit '/users/sign_in'
			fill_in 'Email', :with => 'u1@pmb.dev'
      		fill_in 'Password', :with => 'test12'
			click_button 'Sign in'
			sleep 2
			
			#set cleared for debt one to true
			visit '/debts/'+@debt.id.to_s+'/edit'
			page.check('Cleared')
			click_button 'Update Debt'
			
			#destroy cleared debt
			sleep 10
			visit '/'
			click_link 'Destroy'
			#sleep 2
			page.driver.browser.switch_to.alert.accept
			#assert_equal debts_path("/debts"), current_path
			current_path.should == debts_path
			#page.should have_content 'Debt was successfully deleted'
			sleep 5
		end
end
						
