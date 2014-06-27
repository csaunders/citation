class ArticlesController < Controller
  engine :erb
  helper :blue_form
  map '/articles'

  def index
    @bookmarklet = Bookmarklet.new(User.first)
    @title = "Articles"
    @articles = Article.all
  end

  def show(id)
    @article = Article.where(id: id).first
    @title = "Articles / #{@article.title}"
  end

  def new
    @title = "Create a new article"
    @article = Article.new
  end

  def save
    if request.post?
      data = request.subset(:id, :url, :title, :tagstring)

      form = ArticleForm.new(data)
      form.save
    end

    redirect ArticlesController.r('')
  end
end
