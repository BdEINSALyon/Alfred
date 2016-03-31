class YurplanLinkController < ApplicationController
  def index
    @yurplans = Yurplan.all
    if @yurplans.count <= 0
      redirect_to '/admin/yurplan'
    end
  end

  def load
    @yurplan = Yurplan.find y_id

  end

  private

  def y_id
    params.require(:id)
  end
end
