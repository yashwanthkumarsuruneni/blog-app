class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end
 # method for saving new article posted in database
	def create
		  @article = current_user.articles.create(article_params)
      respond_to do |format|
      if @article.save
      	format.html { redirect_to @article, notice: 'Article was successfully created.' }
      	format.js   {}
      	format.json { render json: @article, status: :created, location: @article }
      else
    		format.html { render action: "new" }
      	format.json { render json: @article.errors, status: :unprocessable_entity }
    	end
  end

	end
 #method to populate the existing article in update view
	def edit
  	@article = Article.where(id: params[:id]).first
	end
 # method to display the posted article
	def show
		@article = Article.where(id: params[:id]).first
	end

	def index
     @articles= Article.paginate(page: params[:page], per_page: 5)
  end
#method for editing the existing article
  def update
    @article = Article.where(id: params[:id]).first
 
    if @article.user_id===current_user.id
       @article.update(article_params)
       redirect_to @article
    else
       redirect_to article_path, :alert => "You are not authorised to update this post!"

    end
  end
#method to delete any existing article 
  def destroy
  @article = Article.where(id: params[:id]).first
    p @article.user_id
    p current_user.id
  	if @article.user_id===current_user.id
    @article.destroy
     	redirect_to articles_path
    else 
    	 redirect_to article_path, :alert => "You are not authorised to delete this post!"
    end
  end

	private
# method to give the attributes permitted to post an article
	def article_params
			params.require(:article).permit(:title, :text,:user_id)
	end
end
