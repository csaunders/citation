class Hyperlink
  attr_reader :url, :title
  def initialize(url: nil, title: title)
    @url = url
    @title = title
  end
end
