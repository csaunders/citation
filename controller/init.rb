# Define a subclass of Ramaze::Controller holding your defaults for all controllers. Note 
# that these changes can be overwritten in sub controllers by simply calling the method 
# but with a different value.
class Controller < Ramaze::Controller
  layout :default
  helper :blue_form, :xhtml
  engine :erb

  def hyperlinks
    [
      Hyperlink.new(url: '/articles', title: 'Articles'),
      Hyperlink.new(url: '/quotes', title: 'Quotes')
    ]
  end

  before_all do
    @hyperlinks = hyperlinks
  end

end

# Here you can require all your other controllers. Note that if you have multiple
# controllers you might want to do something like the following:
#
#  Dir.glob('controller/*.rb').each do |controller|
#    require(controller)
#  end
#
require __DIR__('main')
require __DIR__('articles')
require __DIR__('quotes')
require __DIR__('citations')
