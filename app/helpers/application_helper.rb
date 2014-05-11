module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | DoIndie"      
    end
  end
  
  def youtube_fix(youtube_link)
    youtube_link.gsub(/^[^_]*v=/, '')
  end

  def sortable(column, title = nil)
  	title ||= column.titleize
  	direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  	link_to title, sort: column, direction: direction
  end
end
