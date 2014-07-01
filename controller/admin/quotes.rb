module Admin
  class Quotes < AdminController
    map '/quotes'

    def index
      @quotes = Quote.all
    end
  end
end
