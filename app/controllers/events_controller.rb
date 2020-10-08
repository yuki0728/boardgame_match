class EventsController < ApplicationController
  # ログイン必須ページを指定(ゲストはログインページへリダイレクト)
  before_action :authenticate_user!, only: [:show, :edit, :new]
  before_action :correct_user, only: :destroy

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(events_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to action: :show, id: @event.id
    else
      render :new
    end
  end

  def index
    @search_params = event_search_params
    if @search_params == {}
      # 検索していない場合でもイベント一覧は表示する。
      @events = Event.all
    else
      @events = Event.search(@search_params)
    end
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
      render :edit
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
    params.require(:event).permit(:name, :text, :start_time, :ending_time, :participant_limit,
                                  :tag_list, :img)
  end

  def event_search_params
    params.fetch(:search, {}).permit(:name, :tag_list, :date)
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to root_url if @event.nil?
  end
end
