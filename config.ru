#!/usr/bin/env ruby

# set of logic that gets list of scripts
scripts = Dir["scripts/*.rb"]
scripts.each do
  require "./#{_1}"
end

# get a list of apps that can then be run.
apps = ObjectSpace.each_object(Class).filter do
  _1 < Sinatra::Base && _1 != Sinatra::Application
end

meta_app = Rack::Builder.new do
  apps.each do |a|
    map a.app_path do
      run a.new
    end
  end
end

run meta_app
