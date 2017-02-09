# (с) goodprogrammer.ru
#
# Контроллер, управляющий событиями
class EventsController < ApplicationController
  # встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show, :index]

  # задаем объект @event для экшена show
  before_action :set_event, only: [:show]

  # задаем объект @event от текущего юзера
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

  before_action :password_guard!, only: [:show]
  
  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    # Болванка модели для формы добавления комментария
    @new_comment = @event.comments.build(params[:comment])

    # Болванка модели для формы подписки
    @new_subscription = @event.subscriptions.build(params[:subscription])

    # Болванка модели для формы добавления фотографии
    @new_photo = @event.photos.build(params[:photo])
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      # Используем сообщение из файла локалей ru.yml
      # controllers -> events -> created
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private
  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end
  
  def password_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    # юзер на чужом событии (или не за логином)
    # проверяем, правильно ли передал пинкод
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      # если правильно, запоминаем в куках этого юзера этот пинкод для данного события
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    # проверяем - верный ли в куках пинкод, если нет — ругаемся
    unless @event.pincode_valid?(cookies.permanent["events_#{@event.id}_pincode"])
      flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
      render 'password_form'
    end
  end


  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
