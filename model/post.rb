class Post < Sequel::Model
  many_to_one :user
  many_to_many :tags, left_key: :taggable_id, right_key: :tag_id, join_table: :tags_post_tags

  set_schema do
    primary_key :id
    Integer :user_id

    String :title
    String :body, text: true
    String :html, text: true
    DateTime :created_at, null: false
    DateTime :published_at
    TrueClass :published, default: true
    index [:user_id, :published]
    index [:id, :user_id]
  end

  create_table unless table_exists?

  private
  def before_create
    self.created_at = Time.now.utc
  end
end

class PostsTags < Sequel::Model
  include Taggable
  tagged_on Post
end
