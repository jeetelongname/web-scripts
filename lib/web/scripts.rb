# frozen_string_literal: true

require_relative "scripts/version"

require "sinatra/base"

module Scripts
  class Base < Sinatra::Base
    @@scripts = []
    def self.register_script = @@scripts << self

    def self.each(&block) = @@scripts.each(&block)
  end

  PROJECT_ROOT = Pathname.new(__dir__).parent.parent.to_s

  DB_FILES_DIR = File.join(PROJECT_ROOT, "temps")
end
