class MapsController < ApplicationController
  def index
    @events = Event.all.to_json.html_safe
    @search_params = event_search_params
  end

  def map
    @search_params = event_search_params
    if @search_params == {}
      # 検索していない場合でもイベント一覧は表示する。
      @events = Event.all.to_json.html_safe
    else
      @events = Event.event_search(@search_params).to_json.html_safe
    end
    respond_to do |format|
      format.js { @events }
    end
  end

  def event_search_params
    params.fetch(:event_search, {}).permit(:name, :tag_list, :date, :keyword)
  end
end
