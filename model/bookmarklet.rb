class Bookmarklet
  attr_reader :token, :script_path, :citation_path

  def self.host=(host)
    @@host = host
  end

  def initialize(user)
    @token = user.token
    @script_path = determine_script_path
    @citation_path = "#{@@host}/#{Citations.r('')}"
  end

  def generate(context)
    context.render_file(__DIR__('../view/bookmarklet.erb'), token: token, script_path: script_path, citation_path: citation_path)
  end

  private

  def determine_script_path
    "#{@@host}/js/quote_article.js"
  end
end
