
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil) per_page(value) end
        def paginates_per(value = nil) per_page(value) end
        def total_count() count end
        def last_page? 
          current_page >= total_pages 
        end
      end
    end
    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end