class AdminController < Controller
  def self.map(location)
    super "/admin#{location}"
  end
  map ''

  def self.configuration
    @@configuration ||= {}
  end

  def self.skip_authentication(*actions)
    raise StandardError, 'Missing required actions to skip' if actions.nil?
    configuration[:skip_authentication] ||= {}
    configuration[:skip_authentication][self] = actions.map { |a| a.to_s }
  end
  skip_authentication :unauthorized

  before_all do
    redirect AdminController.r('unauthorized') unless authorized?
  end

  def skip_authentication
    AdminController.skip_authentication
  end

  def index
    redirect Admin::Home.r('')
  end

  def unauthorized
    @title = "You are not authorized to see this content"
  end

  def hyperlinks
    if authorized?
      [
        Hyperlink.new(url: Admin::Home.r(''), title: 'Home'),
        Hyperlink.new(url: Admin::Articles.r(''), title: 'Articles')
      ]
    else
      super
    end
  end

  protected

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def set_user(user)
    session[:user_id] = user.id if user
  end

  def authorized?
    skip_authentication? || current_user
  end

  def skip_authentication?
    skipped_actions.include? action.method
  end

  def skipped_actions
    AdminController.configuration[:skip_authentication][action.node] || {}
  end
end

require __DIR__('admin/home')
require __DIR__('admin/articles')
require __DIR__('admin/quotes')
require __DIR__('admin/posts')
require __DIR__('admin/auth')
