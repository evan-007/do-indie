class SearchModel < SimpleDelegator

	def text_search(param1, param2, options={})
		query = options[:query]
		if query.present?
			__getobj__.where("#{param1} @@ :q or #{param2} @@ :q", q:query).order(updated_at: :desc)
		else
			order(updated_at: :desc)
		end
	end
end

# SearchModel.new(User.all).text_search('username', 'email', query: "admin")

# SearchModel.new(User.all).text_search('username', 'email')