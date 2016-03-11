ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'dependency_grapher'
require 'bundler'

class ActionController::TestCase

  # Add more helper methods to be used by all tests here...
  #@@logger = DependencyGrapher::Logger.new

  #def setup
  #puts "in setup"
  #@@logger.enable
  #end

  #def teardown
  #p "in teardown"
  #@@logger.disable
  #end

  #Minitest.after_run do 
  #analyzer = DependencyGrapher::Grapher.new(@@logger.dependencies)
  ##grapher = DependencyGrapher::Grapher.new(@@logger.dependencies)
  #end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  @@logger = DependencyGrapher::Logger.new

  def setup
    puts "in setup"
    @@logger.enable
  end

  def teardown
    p "in teardown"
    @@logger.disable
  end

  Minitest.after_run do 
    analyzer = DependencyGrapher::Grapher.new(@@logger.dependencies)
    #grapher = DependencyGrapher::Grapher.new(@@logger.dependencies)
  end
end
