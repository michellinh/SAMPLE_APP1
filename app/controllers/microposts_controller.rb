class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_micropost, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    save_micropost
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost_deleted"
      redirect_to request.referer || root_url
    else
      flash[:warning] = t "micropost_not_deleted"
      redirect_to root_url
    end
  end

  private

  def save_micropost
    if @micropost.save
      flash[:success] = t "micropost_created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per Settings.p_page
      flash[:warning] = t "micropost_not_created"
      render "static_pages/home"
    end
  end

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def load_micropost
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
