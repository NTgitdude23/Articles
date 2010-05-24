class ArticlesController < ApplicationController
  unloadable
  
  def index
    @page_title = 'Articles'
    if params[:category_id]
      @category = Category.find_by_permalink(params[:category_id])
      @page_title << " in category #{@category.title}"
    end
    if params[:tag]
      @page_title << " tagged with '#{params[:tag]}'"
    end
    if params[:permalink]
      @user = User.find_by_permalink(params[:permalink])
      @page_title << " writen by #{@user.name}"
    end
    if params[:year]
      @page_title << " from #{params[:day]} #{Date::MONTHNAMES[params[:month].to_i] unless params[:month].nil?} #{params[:year]}"
    end
    
    @articles = Article.in_time_delta( params[:year], params[:month], params[:day] ).published.tagged_with(params[:tag], :on => :tags).authored_by(@user).categorised(@category).paginate( :page => params[:page], :per_page => params[:per_page] || Article.per_page, :include => [:created_by] )
    
    @tags = Article.published.authored_by(@user).categorised(@category).tag_counts(:limit => 20)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @articles }
      format.json { render :json => @articles }
      format.rss 
      format.js 
    end
  end

  def show
    @article = Article.published.find_by_permalink(params[:year], params[:month], params[:day], params[:permalink])
    @images = @article.assets.images
    @documents = @article.assets.documents
    
    @page_title = @article.title
    @page_description = @article.description
    @page_keywords = @article.tag_list
    
    @tags = @article.tag_counts
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end
  
  def preview
    @page_class = 'show'
    @article = Article.new(session[:article_preview])
    asset_ids = session[:article_preview][:asset_ids]
    @images = Asset.images.all(:conditions => {:id => asset_ids }).sort{|x,y| asset_ids.index(y.id.to_s) <=> asset_ids.index(x.id.to_s) }.reverse
    @documents = Asset.documents.all(:conditions => {:id => asset_ids }).sort{|x,y| asset_ids.index(y.id.to_s) <=> asset_ids.index(x.id.to_s) }.reverse

    @article.id = 0
    @article.published_at = Time.now
    @article.created_by = current_user
    @article.permalink = 'preview'
    session[:article_preview] = nil
    render :action => "show"
  end
end