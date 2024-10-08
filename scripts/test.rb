#!/usr/bin/env ruby

require "sinatra/base"

class Test < Scripts::Base
  register_script

  def self.app_path = "/test"

  get "/" do
    "hello world"
  end
end
