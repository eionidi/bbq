# (с) goodprogrammer.ru
#
# Модель Подписки
class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, presence: true

  # проверки выполняются только если user не задан (незареганные приглашенные)
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'
  validate :user_email_exist

  # для данного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'

  # для данного event_id один email может использоваться только один раз (если нет юзера, анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :event_belong_to_current_user

  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # переопределяем метод, если есть юзер, выдаем его email,
  # если нет -- дергаем исходный переопределенный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
  
  private
  
  def user_email_exist
    if user.nil? && User.find_by_email(user_email).present?
      errors.add(:empty, I18n.t('controllers.subscription.error_exist_email'))
    end
  end
  
  def event_belong_to_current_user
    if event.user == user
      errors.add(:empty, I18n.t('controllers.subscription.error_owner'))
    end
  end
end
