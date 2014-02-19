class DataAdmin
	
	def self.login_elements
		OpenStruct.new(:sign_in_link=>"Sign in",:username_id=>"username",:password_id=>"password",:submit_id=>"login_submit_id")
	end
	def  self.adminstration_elements
		OpenStruct.new(:link=>"Administration",:project_link=>"projects",:status_id =>"status",:apply=>"small",:new_project=>"New project")
	end
	def self.admin_project_elements
		OpenStruct.new( :project_name=>"project_name", :bold=>"jstb_strong", :project_description=>"project_description", :project_identifier=>"project_identifier" , :project_homepage=>"project_homepage", :project_is_public=>"project_is_public" , :project_parent_id=>"project_parent_id" ,:submit_name=>"commit" )
	end
		
	def self.admin_data
		OpenStruct.new(:username => "admin", :password=>"admin", :firstname=>'Redmine', :lastname=>'Admin',:mail=>'admin@example.net', :language=>'(auto)', :mail_notification=>"or any event on all my projects",:pref_time_zone=>" ",:pref_comments_sorting=>"In chronological order")
	end

	def self.website_url
	 OpenStruct.new(:url => "localhost:3000")
	end

	def self.admin_project_status
		OpenStruct.new(:status=>"all")
	end

	def self.admin_project_data
		OpenStruct.new(:project_name=> ("project 1"+ Time.now.to_s ) , :project_description => " project description Test test test" , :project_identifier=> self.rand_time,
		:project_homepage => "Home page")
	end
	
	def self.rand_time
		current_time = Time.now.to_s
		current_time = current_time.gsub(/[-:+ ]/, '_')
	end
	
end
