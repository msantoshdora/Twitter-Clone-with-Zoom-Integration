module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    # default_url = "#{root_url}images/kitten.jpg"
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}&d=monsterid"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=monsterid"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end