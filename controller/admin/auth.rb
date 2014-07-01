module Admin
  class Auth < AdminController
    map '/auth'
    skip_authentication :index, :signup, :login, :create

    def index
      @title = "Auth Index"
    end

    def signup
      @user = User.new
    end

    def login
      @user = User.new
    end

    def create
      if request.post?
        attrs = request.subset('username', 'password', 'confirmation')
        if User.exists?(attrs['username'])
          user = User.authenticate(attrs)
        else
          user = User.new(username: attrs['username'])
          user.set_password(password: attrs['password'], confirmation: attrs['confirmation'])
          user.save
        end
      end
      set_user(user)
      redirect Admin::Home.r('')
    end

    def logout
      session.clear
    end
  end
end
