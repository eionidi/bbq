# (с) goodprogrammer.ru
#
# Модель события
class Event < ActiveRecord::Base
  # событие всегда принадлежит юзеру
  belongs_to :user
  has_many :comments
  # has_many :subscriptions, :dependent => :delete_all
#   has_many :subscribers, through: :subscriptions, source: :user, :dependent => :delete_all

  # юзера не может не быть
  validates :user, presence: true

  # заголовок должен быть, и не длиннее 255 букв
  validates :title, presence: true, length: {maximum: 255}

  validates :address, presence: true
  validates :datetime, presence: true


end

