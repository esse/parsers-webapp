require 'bundler'

Bundler.require(:default)

require_relative 'config/sources'
require_relative 'lib/fetcher'
require_relative 'lib/pipeline'
require_relative 'lib/parser'
require_relative 'lib/command'
require_relative 'lib/uploader'
