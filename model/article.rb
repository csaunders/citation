class Article < Sequel::Model
  one_to_many :quotes
  many_to_many :tags, left_key: :taggable_id, right_key: :tag_id, join_table: :taggables

  set_schema do
    primary_key :id
    String :url

    String :contents, text: true
  end

  create_table unless table_exists?

  def tagstring
    tags.join(' ')
  end
end
