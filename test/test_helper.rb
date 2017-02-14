$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'distance_finder'

require "net/http"
require "json"
require 'socket'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
