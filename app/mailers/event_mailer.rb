class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: I18n.t('actionmailer.subscription', title: event.title)
  end

  # Письмо о новом комментарии на заданный email
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: I18n.t('actionmailer.comment', title: event.title)
  end

  def photo(event, photo, email)
    @event = event
    @user = photo.user
    @photo = photo

    mail to: email, subject: I18n.t('actionmailer.photo', title: event.title)
  end
end
