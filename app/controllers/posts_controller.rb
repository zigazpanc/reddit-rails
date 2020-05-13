class PostsController < ApplicationController 
    before_action :authenticate_account!, except: [:index, :show]
    before_action :set_post, only: [:show]
    before_action :auth_subscriber, only: [:new]

    def index 
        @posts = post.all
        
    end

    def show
        @comment = Comment.new
        @community = Community.find(params[:community_id])
    end 

    def new
        @community = Community.find(params[:community_id])
        @post = Post.new
    end

    def create
        @post = Post.new post_values
        @post.account_id = current_account.id
        @post.community_id = params[:community_id]
        if @post.save
            redirect_to community_path(@post.community_id) 
        else
            @community = Community.find(params[:community_id])
            render :new
        end
    end

    def edit
    end

    def destroy
        @post.destroy
        respond_to do |format|
          format.html { redirect_to posts_url}
        end
      end

    private

    def set_post
        @post = Post.includes(:comments).find(params[:id])
    end

    def auth_subscriber
        unless Subscription.where(community_id: params[:community_id], account_id: current_account.id).any? 
            redirect_to root_path
        end
    end

    def post_values
        params.require(:post).permit(:title, :body, :image)
    end

end