class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :participant_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @comment = Comment.create(comment_params)
    @comment.event_id = params[:event_id]
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    if comment.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  # コメントの作成者以外は削除できない
  def correct_user
    comment = current_user.comments.find_by(id: params[:id])
    redirect_back(fallback_location: root_path) if comment.nil?
  end

  # 参加者以外は権限を持たない
  def participant_user
    user = Event.find_by(id: params[:event_id]).participated_by?(current_user)
    redirect_back(fallback_location: root_path) if user.nil?
  end

end