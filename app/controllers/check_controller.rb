class CheckController < ApplicationController

  before_action :authenticate_user!

  def index
    @participants = Participant.all.to_json
  end

  private
  def authenticate_user!
    super
  end
end
