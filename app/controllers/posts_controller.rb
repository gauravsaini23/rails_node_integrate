class PostsController < ApplicationController

  def index
    @post1 = Post.find(1)
    @post2 = Post.find(2)
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    uri = URI.parse( "http://sharp-frost-7793.herokuapp.com/send" )
    http = Net::HTTP.new(uri.host, uri.port)
    query = {:text => @post.name,:id=> @post.id}
    req = Net::HTTP::Get.new(uri.path)
    req.set_form_data(query)
    req = Net::HTTP::Get.new( uri.path+ '?' + req.body )
    res = http.request(req)
    @post1 = Post.first
    @post2 = Post.last
    redirect_to posts_url
  end

end

