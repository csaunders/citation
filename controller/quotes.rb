class Quotes < Controller
  map '/quotes'

  def index
    @quotes = Quote.all
  end
end
