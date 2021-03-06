# (с) goodprogrammer.ru
#
# Модель события
class Event < ActiveRecord::Base
  # событие всегда принадлежит юзеру
  belongs_to :user
  has_many :comments
  has_many :subscriptions, :dependent => :delete_all
  has_many :subscribers, through: :subscriptions, source: :user, :dependent => :delete_all
  has_many :photos

  # юзера не может не быть
  validates :user, presence: true

  # заголовок должен быть, и не длиннее 255 букв
  validates :title, presence: true, length: {maximum: 255}

  validates :address, presence: true
  validates :datetime, presence: true

  # Метод, который возвращает всех, кто пойдет на событие:
  # всех подписавшихся и организатора
  def visitors
    (subscribers + [user]).uniq
  end
  
  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end
