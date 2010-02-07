require 'rubygems'
gem 'require'
require 'require'

Require do
  gem :httparty, '=0.5.0' { require 'httparty' }
  gem(:'rack-test', '=0.5.3') { require 'rack/test' }
  gem :require, '=0.2.1'
  gem(:rake, '=0.8.7') { require 'rake' }
  gem :rspec, '=1.3.0'
  gem(:sinatra, '=0.9.4') { require 'sinatra/base' }
  
  gemspec do
    author 'Winton Welsh'
    dependencies do
      gem :require
    end
    email 'mail@wintoni.us'
    name 'a_b_plugin'
    homepage "http://github.com/winton/#{name}"
    summary "Talk to a_b from your Rails or Sinatra app"
    version '0.1.0'
  end
  
  bin { require 'lib/gem_template' }
  
  lib {
    require 'yaml'
    require "lib/a_b_plugin/core_ext/array"
    require "lib/a_b_plugin/core_ext/module"
    require "lib/a_b_plugin/api"
    require "lib/a_b_plugin/helper"
  }
  
  rails_init { require 'lib/gem_template' }
  
  rakefile do
    gem(:rake) { require 'rake/gempackagetask' }
    gem(:rspec) { require 'spec/rake/spectask' }
    require 'require/tasks'
  end
  
  spec_helper do
    require 'require/spec_helper'
    require 'pp'
    require 'cgi'
    require 'json'
    
    gem :'rack-test'
    gem :sinatra

    require "spec/fixtures/rails/config/environment"
    require "rails/init"
    require "spec/fixtures/sinatra"
  end
end