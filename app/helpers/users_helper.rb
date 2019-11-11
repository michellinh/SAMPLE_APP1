module UsersHelper
  def gravatar_for user, options = {size: Settings.size}
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def find_following id
    @active = current_user.active_relationships.find_by followed_id: id
    return @active if @active

    flash[:warning] = t "not_found_active_relationship"
    redirect_to root_url
  end

  def do_following
    current_user.active_relationships.build
  end
end
