class AdminUser < ApplicationRecord
	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits
	#this is users if the class name was still users and we wanted to use another table
	#self.table_name  = "admin_users"
end
