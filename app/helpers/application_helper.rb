module ApplicationHelper

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Divise.mappings[:user]
	end
end
