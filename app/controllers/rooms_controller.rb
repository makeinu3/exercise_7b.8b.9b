class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @current_entry = Entry.create(user_id: current_user.id, room_id: @room.id)
    @another_entry = Entry.create(entry_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end


  private

  def entry_room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id).merge(room_id: @room.id)
  end


end
