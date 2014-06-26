class Taggable < Sequel::Model
  set_schema do
    Integer :tag_id
    Integer :taggable_id
    index [:tag_id, :taggable_id], unique: true
  end
  create_table unless table_exists?
end
