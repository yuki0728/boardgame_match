class ParticipationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    participant = current_user.participations.build(event_id: params[:event_id])
    if participant.save
      flash[:success] = "イベントに参加しました"
      participant.notify_owner_by(current_user, "participation")
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "イベントに参加出来ませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    participant = Participation.find_by(event_id: params[:event_id], user_id: current_user.id)
    if participant.destroy
      flash[:success] = "イベントの参加を取り消しました"
      participant.notify_owner_by(current_user, "cancellation")
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "イベントの参加の取り消しに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

end
