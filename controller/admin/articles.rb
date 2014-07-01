module Admin
  class Articles < AdminController
    engine :erb
    helper :blue_form
    map '/articles'

    def index
      @bookmarklet = Bookmarklet.new(User.first)
      @title = "Articles"
      @articles = current_user.articles
    end

    def show(id)
      @article = Article.where(id: id, user_id: current_user.id).first
      @title = "Articles / #{@article.title}"
    end

    def new
      @title = "Create a new article"
      @article = Article.new
    end

    def save
      if request.post?
        data = request.subset(:id, :url, :title, :tagstring)

        form = ArticleForm.new(current_user, data)
        form.save
      end

      redirect Articles.r('')
    end
  end
end
