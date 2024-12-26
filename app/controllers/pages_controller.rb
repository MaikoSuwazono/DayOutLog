class PagesController < ApplicationController
  skip_before_action :require_login
  
  def terms_of_service; end
  def privacy; end
end
