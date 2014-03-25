module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | DoIndie"      
    end
  end
  
  def youtube_fix(youtube_link)
    youtube_link.gsub(/^[^_]*v=/, '')
  end
end
