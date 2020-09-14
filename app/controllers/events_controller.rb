class EventsController < ApplicationController
  # ログイン必須ページを指定(ゲストはログインページへリダイレクト)
  before_action :authenticate_user!, only: [:show, :edit, new]

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

  def update
    @event = Event.find(params[:id])
    if @event.update(events_params)
      redirect_to @event
    else
      render 'edit'
    end
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
    params.require(:event).permit(:name, :text, :start_time, :ending_time, :participant_limit)
  end
end
