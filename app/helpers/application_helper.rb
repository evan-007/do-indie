module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | DoIndie"      
    end
  end
end
