require 'sequel'
require 'bcrypt'

Sequel::Model.plugin(:schema)
DB=Sequel.sqlite('./app.sqlite')

require __DIR__('taggable')
require __DIR__('tag')
require __DIR__('user')
require __DIR__('article')
require __DIR__('quote')
require __DIR__('hyperlink')
require __DIR__('bookmarklet')

