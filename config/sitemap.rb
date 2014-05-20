# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://doindie.co.kr"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  Band.find_each do |band|
    add band_path(band), lastmod: band.updated_at
  end

  Venue.find_each do |venue|
    add venue_path(venue), lastmod: venue.updated_at
  end

  Event.find_each do |event|
    add event_path(event), lastmod: event.updated_at
  end

  Post.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
