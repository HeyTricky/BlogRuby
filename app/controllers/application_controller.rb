class ApplicationController < ActionController::Base
	before_filter :configure_devise_parameters, if: :devise_controller?
	after_filter :store_location
	protect_from_forgery with: :exception
	before_filter do
		resource = controller_name.singularize.to_sym
		method = "#{resource}_params"
		params[resource] &&= send(method) if respond_to?(method, true)
	end

	def store_location
		return unless request.get? 
		if (request.path != "/users/sign_in" &&
			request.path != "/users/sign_up" &&
			request.path != "/users/password/new" &&
			request.path != "/users/password/edit" &&
			request.path != "/users/confirmation" &&
			request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
		session[:previous_url] = request.fullpath 
	end
end
protected

def configure_devise_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end

def after_sign_out_path_for(resource_or_scope)
	session[:previous_url] || root_path
end


end
