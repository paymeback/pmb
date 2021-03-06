require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the EzbupdaterHelper. For example:
#
# describe EzbupdaterHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe DebtsHelper do
	valuearray = Debtniceview.select('value').map{|elem|elem.value}
	i = 0
	sum1 = 0
	while i < valuearray.size
		sum1 += valuearray[0]
		i += 1
	end
	
	Debt.create(value: '25', description: 'testdata', debitor_id: '2', creditor_id: '3')
	Debt.create(value: '25', description: 'testdata', debitor_id: '3', creditor_id: '2')
	
	DebtsHelper.killdoublesandcross

	valuearray = Debtniceview.select('value').map{|elem|elem.value}
	i = 0
	sum2 = 0
	while i < valuearray.size
		sum2 += valuearray[0]
		i += 1
	end
	
	Debt.last.delete
	Debt.last.delete
	
	it "Crosses will be killed!" do
		sum1.should == sum2
  end	
end
