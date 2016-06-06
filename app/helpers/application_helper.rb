module ApplicationHelper

  # returns the gravatar image for a given user. You can also specify the size.
  # Example: gravatar_for(@user, size: 190)
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    image_tag "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}", alt: user.email, class: "img-circle"
  end
end
