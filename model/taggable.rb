module Taggable
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      set_schema do
        Integer :tag_id
        Integer :taggable_id
        index [:tag_id, :taggable_id], unique: true
      end
      create_table unless table_exists?
    end
  end

  module ClassMethods
    def tagged_on(model)
      table = model.table_name.to_sym
      join_table = "#{table}_tags".to_sym
      model.many_to_many :tags, left_key: :tag_id, right_key: :taggable_id, join_table: join_table
      Tag.many_to_many table, left_key: :taggable_id, right_key: :tag_id, join_table: join_table
    end
  end
end
