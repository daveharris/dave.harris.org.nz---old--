class TagsController < ApplicationController
  # POST /tags
  def create
    @post = Post.find(params[:post_id])

    puts "Attempting to lookup tag '#{params[:tag][:name]}'"
    tag = Tag.find_by_name(params[:tag][:name])
    
    if tag == nil
      puts "Tag #{params[:tag][:name]} not found, creating"
      @post.tags.create(params[:tag])
    else
      tag.posts << @post
      @post.save
    end
    
    redirect_to post_path(@post)
  end

  # GET /tags/1
  def show
    @tag = Tag.find(params[:id])
    @posts_with_tag = Post.find_by_tag(@tag)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
end
