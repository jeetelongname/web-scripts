#!/usr/bin/env ruby
require_relative "lib/web/scripts/"
# set of logic that gets list of scripts
Dir["scripts/*.rb"].each do
  require "./#{_1}"
end

meta_app = Rack::Builder.new do
  Scripts::Base.each do |a|
    map a.app_path do
      run a.new
    end
  end
end

run meta_app
