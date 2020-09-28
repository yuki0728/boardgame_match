class ParticipationsController < ApplicationController
  def create
    participant = current_user.participations.build(event_id: params[:event_id])
    if participant.save
      flash[:success] = "イベントに参加しました"
      redirect_to event_path(params[:event_id])
    else
      flash[:error] = "イベントに参加出来ませんでした"
      redirect_to event_path(params[:event_id])
    end
  end

  def destroy
    participant = Participation.find_by(event_id: params[:event_id], user_id: current_user.id)
    participant.destroy
    redirect_to event_path(params[:event_id])
  end
end
