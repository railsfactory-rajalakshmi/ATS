require 'mysql'
class Connect
	
	def self.db_connect
		con = Mysql.new 'localhost', 'root', 'root', 'redmine_development'
	end
end