class UserBookmarksController < ApplicationController
  before_action :set_user_bookmark, only: %i[ show update destroy ]

  # GET /user_bookmarks
  def index
    @user_bookmarks = UserBookmark.all

    render json: @user_bookmarks
  end

  # GET /user_bookmarks/1
  def show
    render json: @user_bookmark
  end

  # POST /user_bookmarks
  def create
    @user_bookmark = UserBookmark.new(user_bookmark_params)

    if @user_bookmark.save
      render json: @user_bookmark, status: :created, location: @user_bookmark
    else
      render json: @user_bookmark.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_bookmarks/1
  def update
    if @user_bookmark.update(user_bookmark_params)
      render json: @user_bookmark
    else
      render json: @user_bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_bookmarks/1
  def destroy
    @user_bookmark.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_bookmark
      @user_bookmark = UserBookmark.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_bookmark_params
      params.expect(user_bookmark: [ :user_id, :bookmarkable_id, :bookmarkable_type ])
    end
end
