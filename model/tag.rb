class Tag < Sequel::Model
  set_schema do
    primary_key :id
    String :name
    index :name
  end

  create_table unless table_exists?

  def self.normalize(tag)
    tag.strip.downcase
  end

  def self.find_or_create_missing(tags)
    tags = tags.sort.uniq
    entries = order(:name).where(name: tags).all
    tags.map do |tag|
      entry = entries.shift
      if entry.nil? || entry.name != tag
        entry = new(name: tag).save
        entry.save
      end
      entry
    end
  end
end
