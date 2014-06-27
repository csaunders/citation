# This file contains your application, it requires dependencies and necessary
# parts of the application.
require 'rubygems'
require 'ramaze'
require 'securerandom'
require 'pry'
require 'pry-debugger'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

require __DIR__('model/init')
require __DIR__('controller/init')

Bookmarklet.host = 'localhost:7000'
