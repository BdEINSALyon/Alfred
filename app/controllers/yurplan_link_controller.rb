class YurplanLinkController < ApplicationController
  def index
    @yurplans = Yurplan.all
    if @yurplans.count <= 0
      redirect_to '/admin/yurplan'
    end
  end

  # noinspection RailsChecklist01
  def check
    @ticket = Participant.find_by_ticket_code params[:ticket_code]
    @token = get_token_for @ticket.yurplan
    # noinspection RubyStringKeysInHashInspection
    if HTTParty.put("https://api.yurplan.com/v1/events/#{@ticket.yurplan.event_id}/tickets/#{@ticket.ticket_code}/check?by_token=true",
                 headers:{'Authorization' => "Bearer #{@token}"})['status'] == 200
      flash[:notice] = 'Billet validé'
      @ticket.check_date = Time.now
    else
      flash[:error] = 'Le billet était déjà validé'
    end
    @ticket.checked = true
    @ticket.save
    redirect_to list_url
  end

  # noinspection RailsChecklist01
  def uncheck
    @ticket = Participant.find_by_ticket_code params[:ticket_code]
    @token = get_token_for @ticket.yurplan
    # noinspection RubyStringKeysInHashInspection
    if HTTParty.put("https://api.yurplan.com/v1/events/#{@ticket.yurplan.event_id}/tickets/#{@ticket.ticket_code}/uncheck?by_token=true",
                           headers:{'Authorization' => "Bearer #{@token}"})['status'] == 200
      flash[:notice] = 'Billet dévalidé'
      @ticket.check_date = nil
    else
      flash[:error] = 'Le billet était déjà dévalidé'
    end
    @ticket.checked = false
    @ticket.save
    redirect_to list_url
  end

  # noinspection RailsChecklist01
  def load
    @yurplan = Yurplan.find y_id[:id]
    @token = get_token_for @yurplan
    # noinspection RubyStringKeysInHashInspection
    HTTParty.get("https://api.yurplan.com/v1/events/#{@yurplan.event_id}/tickets?range=0-999999999",
                 headers:{'Authorization' => "Bearer #{@token}"})['results'].each do |t|
      if t['status'] == 1
        # noinspection RailsChecklist01
        p = Participant.find_or_create_by ticket_code: t['token'] do |p|
          p.first_name = t['first_name']
          p.last_name = t['last_name']
        end
        if t['check_status'] == 1
          p.checked = true
          p.check_date = Time.at(t['check_date']).to_datetime
        end
        p.yurplan = @yurplan
        p.save
      end
    end
  end

  # @param [Yurplan] plan
  def get_token_for(plan)
    HTTParty.post('https://api.yurplan.com/v1/token',
                  :body => {
                      :client_id => plan.client_id,
                      :client_secret => plan.client_secret,
                      :grant_type => 'client_credentials',
                      :scope => 'pro',
                  })['results']['access_token']
  end

  private

  def y_id
    params.require(:yurplan).permit(:id)
  end
end
