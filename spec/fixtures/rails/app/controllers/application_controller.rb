# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def controller_respond_to
    render :text => private_methods.collect(&:to_s).include?(params[:method]) ? '1' : '0'
  end
  
  def helper_respond_to
    render :inline => "<%= private_methods.collect(&:to_s).include?(params[:method]) ? 1 : 0 %>"
  end
  
  def destroy_cookie
    AB.instance = self
    AB::Cookies.set('a_b', nil)
    render :nothing => true
  end
  
  def get_cookie
    AB.instance = self
    render :text => AB::Cookies.get('a_b')
  end
  
  def set_cookie
    AB.instance = self
    AB::Cookies.set('a_b', 'test')
    render :nothing => true
  end
end