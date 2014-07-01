module Admin
  class Home < AdminController
    map '/home'

    def index
      @title = "Welcome to your Admin"
    end
  end
end
