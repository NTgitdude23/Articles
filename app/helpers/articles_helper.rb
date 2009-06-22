module ArticlesHelper
  
  def article_categories
    tabs = Category.with( :articles ).collect do |category|
      content_tag :li, link_to( h(category.title), [category, :articles] )
    end
    content_tag( :h2, 'Categories' ) + content_tag( :ul, tabs.join, :class => "categories" )
  end
  
  def comments_link(article)
    if(article.comments.count!=0)
      "|&nbsp;&nbsp;#{link_to('Comment'.pluralize, article_permalink(article, :anchor => 'comments'))} (#{article.comments.count.to_s})"
    else
      "#{(article.commentable?)? '|' : ''}&nbsp;&nbsp;#{link_to 'Comment', article_permalink(article, :anchor => 'comments') if article.commentable?}"
    end
  end

  def digg_link(article, html_options = {})
    link_to 'Digg', "http://digg.com/submit?phase=2&amp;url=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'digg-submit', :title => 'Digg this!')
  end

  def delicious_link(article, html_options = {})
    link_to 'delicious', "http://del.icio.us/post?url=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'delicious-submit', :title => 'Save to delicious')
  end
  
  def facebook_link(article, html_options = {})
    link_to 'Facebook', "http://www.facebook.com/sharer.php?u=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'facebook-submit', :title => 'Share on Facebook')
  end
  
  def stumble_link(article, html_options = {})
    link_to 'Stumble Upon', "http://www.stumbleupon.com/submit?url=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'stumble-submit', :title => 'Stumble on this')
  end
  
  def mail_link(article, html_options = {})
    mail_to nil, "Email", html_options.reverse_merge( :subject => article.title, :body => article_permalink(article, :only_path => false), :class => 'share-link', :id => 'mail-link', :title => 'Email this to a friend')
  end
  
  def twitter_link(article, html_options = {})
    link_to 'Twitter', "http://twitter.com/home?status=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'twitter-submit', :title => 'Tweet this')
  end
  
  def reddit_link(article, html_options = {})
    link_to 'Reddit', "http://www.reddit.com/submit?url=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'reddit-submit', :title => 'Reddit this!')
  end
    
  def technorati_link(article, html_options = {})
    link_to 'Technorati', "http://technorati.com/faves/?add=#{article_permalink(article, :only_path => false)}", html_options.reverse_merge(:class => 'share-link', :id => 'technorati-submit', :title => 'Technorati this!')
  end
  
  def archive(options = {} )
    this_year = params[:year] || Time.now.year
    html = ''
   
    all_articles = Article.find(:all, :select => 'published_at', :order => "published_at DESC", :conditions => ['published_at <= ?', Time.now ])
    grouped_by_year = all_articles.group_by{ |a| a.published_at.year  }.sort.reverse
    grouped_by_year.each do |year, articles|
      html << '<li>'
      html << link_to("#{year}", {:controller => '/articles', :action => 'index', :year => year, :month => nil, :day => nil})
      html << (" (#{articles.size})")
      if this_year.to_i == year
        grouped_by_month = articles.group_by{ |a| a.published_at.month  }.sort.reverse
        html << '<ul>'
        grouped_by_month.each do |month, articles|
          html << '<li>'
          html << link_to("#{Date::MONTHNAMES[month]}", {:controller => '/articles', :action => 'index', :year => year, :month => month, :day => nil})
          html << (" (#{articles.size})")
          html << '</li>'
        end
        html << '</ul>'
      end
      html << '</li>'
    end
    content_tag :ul, html, options.reverse_merge!( :class => 'archive' ) unless html.empty?
  end
  
  def related_articles(content_node)
    articles = Article.find_tagged_with content_node.tag_list, :conditions => ['published_at <= ? AND content_nodes.id != ?', Time.now, content_node.id ], :limit => 3,  :include => :created_by
    articles_list(articles)
  end
  
  def recent_articles(limit = 3)
    articles =  Article.published.all( :limit => limit, :order => 'published_at DESC')
    articles_list(articles)
  end
  
  def articles_list(articles)
    return if articles.empty?
    articles.collect! { |article| content_tag( 'li', "#{link_to(article.title, article_permalink(article))}")    }
    content_tag( 'ul', articles.join, :class => 'article-list' )
  end
  
end
