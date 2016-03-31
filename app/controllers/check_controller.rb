class CheckController < ApplicationController

  before_action :authenticate_user!

  def index
    @participants = Participant.all.to_json
  end

  def data
    respond_to do |f|
      f.html { redirect_to :index }
      f.json { render json: Participant.select('participants.id, first_name, last_name, ticket_code').all }
    end
  end

  private
  def authenticate_user!
    super
  end
end
