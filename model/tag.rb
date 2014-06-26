class Tag < Sequel::Model
  many_to_many :articles, left_key: :tag_id, right_key: :tagged_id, join_table: :taggables
  many_to_many :quotes, left_key: :tag_id, right_key: :tagged_id, join_table: :taggables

  set_schema do
    primary_key :id
    String :name
  end

  create_table unless table_exists?
end
