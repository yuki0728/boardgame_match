class EventsController < ApplicationController
  # before_action :sign_in_required, only: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(events_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to action: :show, id: @event.id
    else
      render :index
    end
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_url
    else
      redirect_to events_url
    end
  end

  private

  def events_params
    params.require(:event).permit(:name, :text, :start_time, :ending_time)
  end
end
