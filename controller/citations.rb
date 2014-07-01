require 'pry-debugger'
class Citations < Controller
  map '/citations'
  trait :default_action_name => 'create'

  def create
    attrs = request.subset(:token, :quote, :url, :title)
    user = fetch_user(attrs['token'])
    respond('Unauthorized', status: 401) unless user

    article = fetch_or_create_article(user, attrs['title'], attrs['url'])
    article.add_quote(contents: attrs['quote'])
    respond('Citation.Success("abracadabra")')
  end

  private

  def fetch_user(token)
    User.where(token: token).first
  end

  def fetch_or_create_article(user, title, url)
    unless article = Article.where(title: title, url: url, user_id: user.id).first
      article = Article.new(user_id: user.id, title: title, url: url)
      article.save
    end
    article
  end
end
