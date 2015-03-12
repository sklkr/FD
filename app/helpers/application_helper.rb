module ApplicationHelper
	def nav_link(link_text, link_path)
	  class_name = link_path.include?(params['controller'].split('/')[2]) ? 'active' : ''
	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path + "#container-tabs"
	  end
	end

	def nav_with_target(link_text, link_path, target)
	  class_name = current_page?(link_path) ? 'active' : ''

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path + target
	  end
	end
end
