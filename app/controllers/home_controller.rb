class HomeController < ApplicationController
  def top
    @search_params = event_search_params
    @sort_list = Event.sort_list
    if user_signed_in?
      @title = "フォロー中のユーザーのイベント"
      @events = current_user.following_user_events.page(params[:page]).per(MAX_DISPLAY_EVENTS)
    else
      @title = "全ユーザーのイベント"
      @events = Event.page(params[:page]).per(MAX_DISPLAY_EVENTS)
    end
    render "events/index"
  end

  private

  def event_search_params
    params.fetch(:event_search, {}).permit(:name, :tag_list, :date, :keyword)
  end
end
