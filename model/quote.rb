class Quote < Sequel::Model
  many_to_one :article
  many_to_many :tags, left_key: :taggable_id, right_key: :tag_id, join_table: :tags_quote_tags

  set_schema do
    primary_key :id
    Integer :article_id
    String :contents, text: true
  end

  create_table unless table_exists?
end

class QuotesTags < Sequel::Model
  include Taggable
  tagged_on Quote
end
