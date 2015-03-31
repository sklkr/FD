module ApplicationHelper
	def nav_link(link_text, link_path)
	if params['controller'].split('/')[2].nil?
	  class_name = link_path.include?(params['action']) ? 'active' : ''
	else
	  class_name = link_path.include?(params['controller'].split('/')[2]) ? 'active' : ''
	end
	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path + "#container-tabs"
	  end
	end

	def nav_with_target(link_text, link_path, target, *args)
	  class_name = current_page?(link_path) ? 'active' : ''

	  content_tag(:li, :class => class_name, :id => args[0]) do
	    link_to link_text, link_path + target
	  end
	end

	def nav_link_customer(link_text, link_path)
		class_name = link_path.include?(params['controller'].split('/')[1]) ? 'active' : ''
		content_tag(:li, :class => class_name) do
		  link_to link_text, link_path + "#container-tabs"
		end
	end
end
