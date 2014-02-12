require_relative 'common_met'
require 'roo'

class Test
	def initialize
		oo = Roo::Excel.new("Template_sbtn.xls")
		data=Roo::Excel.new("test_data_sbtn.xls")
    oo.default_sheet = oo.sheets[1]
		data.default_sheet = data.sheets[0]
		url="http://localhost:3000/users/sign_up"
		@name_temp=[ ]
    @obj= Sample.new(url)
		@name_data = [ ]
		@value = [ ]
		@name_temp=oo.row(11)
		@name =	data.row(5)
		@value = data.row(6)
		@id =[ ]
		@field_type=[ ]
		@field_type = oo.row(13)
		@id = oo.row(14)
		k=1
		m=5
		@ft=[ ]
		@id1=[ ]
		@val=[ ]
		while k <@name.length
		 @ft << @field_type[k]
		 @id1 << @id[k]
		 @val <<@value[m]
		k=k+1
		m=m+1
	end
end

	def enter_values
		j=0
		while j < @id1.length do 
		if (@ft[j]=="text") 
	    @obj.textbox(@id1[j],@val[j])
		end
		if	@ft[j]=="select"
			@obj.dropdown(@id1[j],@val[j])
		end
			if	@ft[j]=="submit"
			@obj.click_button(@id1[j])
		end
		if	@ft[j]=="radio"
			@obj.radiobuttoncheck(@id1[j],@val[j].to_s)
		end
		if	@ft[j]=="email"
			@obj.email(@id1[j],@val[j].to_s)
		end
		if	@ft[j]=="password"
			@obj.password(@id1[j],@val[j].to_s)
		end
     j=j+1
	end
end
end

obj1= Test.new
obj1.enter_values

