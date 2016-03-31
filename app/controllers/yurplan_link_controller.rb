class YurplanLinkController < ApplicationController
  def index
    @yurplans = Yurplan.all
    if @yurplans.count <= 0
      redirect_to '/admin/yurplan'
    end
  end

  def load
    @yurplan = Yurplan.find y_id[:id]
    @token = HTTParty.post('https://api.yurplan.com/v1/token',
                       :body => {
                           :client_id => @yurplan.client_id,
                           :client_secret => @yurplan.client_secret,
                           :grant_type => 'client_credentials',
                           :scope => 'pro',
                       })['results']['access_token']
    # noinspection RubyStringKeysInHashInspection
    HTTParty.get("https://api.yurplan.com/v1/events/#{@yurplan.event_id}/tickets?range=0-999999999",
                 headers:{'Authorization' => "Bearer #{@token}"})['results'].each do |t|
      Participant.find_or_create_by ticket_code: t['token'] do |p|
        p.first_name = t['first_name']
        p.last_name = t['last_name']
      end
    end
  end

  private

  def y_id
    params.require(:yurplan).permit(:id)
  end
end
