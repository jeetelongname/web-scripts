#!/usr/bin/env ruby

require 'sinatra/base'

class Test < Sinatra::Base

  def self.app_path = '/test'

  get '/' do
    'hello world'
  end
end
