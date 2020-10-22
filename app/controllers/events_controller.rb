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
    if params[:tag_name]
      @events = Event.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    elsif @search_params == {}
      # 検索していない場合でもイベント一覧は表示する。
      @events = Event.page(params[:page]).per(10)
    else
      @events = Event.event_search(@search_params).page(params[:page]).per(MAX_DISPLAY_EVENTS)
    end
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments.order(created_at: "DESC").page(params[:page]).per(MAX_DISPLAY_COMMENTS)
    @comment = Comment.new
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

  def search
    @event = Event.find(params[:id])
    @comments = @event.comments.order(created_at: "DESC")
    @comment = Comment.new
  end

  private

  def events_params
    params.require(:event).permit(:name, :text, :start_time, :ending_time, :participant_limit,
                                  :tag_list, :img)
  end

  def event_search_params
    params.fetch(:event_search, {}).permit(:name, :tag_list, :date, :keyword)
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to root_url if @event.nil?
  end
end
