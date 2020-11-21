class SearchsController < ApplicationController
    
  def search
    @search = params[:search]
    if params[:path] == "books"
    @books = Book.search(params[:search], params[:type])
    elsif params[:path] == "users"
    @users = User.search(params[:search], params[:type])
    end
  end
end
