module ApplicationHelper
	def alert_for flash_type
		{
			success: 'alert-success',
			error: 'alert-error',
			alert: 'alert-warning',
			notice: 'alert-info'
		}[ flash_type.to_sym ] || flash_type.to_s
	end

	def context_container
		if controller_name == 'registrations' || controller_name == 'sessions'
			if action_name == 'new'
				return 'background-container full-height'
			else
				return 'background-container'
			end
		else
			return 'container'
		end
	end

	def context_alert_container
		if current_page? new_user_session_path
			'alert-container margin-top'
		else
			'alert-container'
		end
	end

	def form_image_select post
		return image_tag post.image.url(:medium), id: 'image-preview', class: 'img-responsive' if post.image.exists?
		image_tag '', id: 'image-preview', class: 'img-responsive hidden'
	end
end