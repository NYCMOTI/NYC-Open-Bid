class AuthenticationsController < ApplicationController
  def create
    if user.new_record?
      sign_in_user
      redirect_to sign_up_path
    else
      sign_in_user
      redirect_back_or_root_path
    end
  end

  def destroy
    reset_session
    flash[:error] = "To log out completely from OpenBid, please log out of <a href='https://github.com/logout'>Github</a>"
    redirect_to root_path
  end

  private

  def sign_in_user
    @_sign_in_user ||= SignInUser.new(
      auth_hash: auth_hash,
      session: session
    ).perform
  end

  def user
    @_user ||= User.find_or_initialize_by(github_id: auth_hash[:uid])
  end

  def auth_hash
    @_auth_hash ||= request.env['omniauth.auth']
  end

  def redirect_back_or_root_path
    if Admins.verify?(current_user.github_id)
      redirect_to(return_to || admin_auctions_needs_attention_path)
    else
      redirect_to(return_to || root_path)
    end
    clear_return_to
  end

  def return_to
    if return_to_url
      uri = URI.parse(return_to_url)
      "#{uri.path}?#{uri.query}".chomp('?')
    end
  end

  def return_to_url
    session[:return_to]
  end

  def clear_return_to
    session[:return_to] = nil
  end
end
