class ParticipationsController < ApplicationController
  def create
    participant = current_user.participations.build(event_id: params[:event_id])
    participant.save
    redirect_to event_path(params[:event_id])
  end

  def destroy
    participant = Participation.find_by(event_id: params[:event_id], user_id: current_user.id)
    participant.destroy
    redirect_to event_path
  end
end
