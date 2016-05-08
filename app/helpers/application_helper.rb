module ApplicationHelper
	def sortable(attribute, title = nil)
		title ||= attribute.titleize
		css_class = attribute == sort_attribute ? "current-sort #{sort_direction}" : "sort"
		direction = (attribute == sort_attribute && sort_direction == 'asc') ? 'desc' : 'asc'
		link_to title, {:sort => attribute, :direction => direction}, {:class => css_class}
	end 
end
