class TrainerClientMessagesController < ApplicationController
  before_action do 
    authenticate(roles:[UserAuth.roles[:client], UserAuth.roles[:trainer]])
  end

  def index
    if UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:client]
      trainers_ids = TrainerClientMessage.select(:trainer_id).where(client: @user).group(:trainer_id).all.map do |u|
        u[:trainer_id]
      end
      @conversations = Trainer.where(id: trainers_ids).all.decorate.as_json
    elsif UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:trainer]
      clients_ids = TrainerClientMessage.select(:client_id).where(trainer: @user).group(:client_id).all.map do |u|
        u[:client_id]
      end
      @conversations = Client.where(id: clients_ids).all.decorate.as_json
    end

    render status: :ok
  end

  def get
    if UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:client]
      @messages = TrainerClientMessage.where(client: @user, trainer_id: params[:id]).order(created_at: :desc).all
    elsif UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:trainer]
      @messages = TrainerClientMessage.where(client_id: params[:id], trainer: @user).order(created_at: :desc).all
    end

    render status: :ok
  end

  def create
    if UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:client]
      @message = TrainerClientMessage.create!(client: @user, trainer_id: params[:id], body: params[:body], sent_by: :client)
    elsif UserAuth.roles[@user.user_auth.role] == UserAuth.roles[:trainer]
      @message = TrainerClientMessage.create!(client_id: params[:id], trainer: @user, body: params[:body], sent_by: :trainer)
    end

    render status: :ok
  end
end