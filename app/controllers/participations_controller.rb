class ParticipationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    participant = current_user.participations.build(event_id: params[:event_id])
    if participant.save
      flash[:success] = "イベントに参加しました"
      participant.notify_owner_by(current_user, "participation")
      redirect_to event_path(params[:event_id])
    else
      flash[:error] = "イベントに参加出来ませんでした"
      redirect_to event_path(params[:event_id])
    end
  end

  def destroy
    participant = Participation.find_by(event_id: params[:event_id], user_id: current_user.id)
    if participant.destroy
      flash[:success] = "イベントの参加を取り消しました"
      participant.notify_owner_by(current_user, "cancellation")
      redirect_to event_path(params[:event_id])
    else
      flash[:error] = "イベントの参加の取り消しに失敗しました"
      redirect_to event_path(params[:event_id])
    end
  end
end
