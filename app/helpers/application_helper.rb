module ApplicationHelper

  # возвращает путь к аватарке данного юзера
  def user_avatar(user)
  #   TODO: user real avatars
    asset_path('user.png')
  end
end
