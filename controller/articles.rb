class ArticlesController < Controller
  engine :erb
  helper :blue_form
  map '/articles'

  def index
    @articles = DB[:articles]
  end

  def show(id)
    @article = DB[:articles].where(id: id).first
  end

  def new
    @article = Article.new
  end

  def save
    redirect ArticlesController.r('') unless request.post?
  end
end
