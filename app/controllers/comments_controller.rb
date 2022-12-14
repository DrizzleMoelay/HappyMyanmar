class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to place_path(@comment.place)
    else
      @place = @comment.place
      @comments = @place.comments
      render "places/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,place_id: params[:place_id] )
  end
end
