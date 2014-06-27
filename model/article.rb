class Article < Sequel::Model
  one_to_many :quotes
  many_to_one :user
  many_to_many :tags, left_key: :taggable_id, right_key: :tag_id, join_table: :tags_article_tags

  set_schema do
    primary_key :id
    Integer :user_id

    String :url
    String :title
    index :user_id
  end

  create_table unless table_exists?

  def tagstring
    tags.join(',')
  end
end

class ArticlesTags < Sequel::Model
  include Taggable
  tagged_on Article
end

class ArticleForm
  attr_reader :tagstring
  def initialize(attrs)
    @tagstring = attrs.delete('tagstring')
    @article = DB[:articles].where(id: attrs['id']).first || Article.new
    @article.set(attrs)
  end

  def save
    tags = tagstring.split(',').map { |t| Tag.normalize(t) }
    tag_entities = Tag.find_or_create_missing(tags)

    @article.save
    tag_entities.each { |tag| @article.add_tag(tag) }
  end
end
