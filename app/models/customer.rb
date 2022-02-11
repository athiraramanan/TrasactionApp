class Customer < ApplicationRecord
	def customer_details
		json={}
		json['name'] = (first_name && last_name) ? first_name + '' +last_name : first_name 
		json['email'] = email
		json
	end
end
