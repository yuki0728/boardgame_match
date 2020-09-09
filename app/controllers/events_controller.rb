class EventsController < ApplicationController
  # before_action :sign_in_required, only: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.posts.build(post_params)
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @post.destroy
    redirect_to request.referrer || root_url
  end
end
