require 'fastlane/core_ext/string' # this has to be above most of the other requires
require 'fastlane/version'
require 'fastlane/actions/actions_helper' # has to be before fast_file
require 'fastlane/fast_file'
require 'fastlane/dependency_checker'
require 'fastlane/runner'
require 'fastlane/setup'
require 'fastlane/lane'
require 'fastlane/fastlane_folder'
require 'fastlane/junit_generator'
require 'fastlane/lane_manager'
require 'fastlane/action'
require 'fastlane/action_collector'
require 'fastlane/supported_platforms'
require 'fastlane/configuration_helper'
require 'fastlane/command_line_handler'

require 'fastlane_core'

module Fastlane
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore

  module Helper
    def self.log
      @@log ||= Logger.new($stdout)

      @@log.formatter = proc do |severity, datetime, progname, msg|
        string = "#{severity}: "
        second = "#{msg}\n"

        if severity == "DEBUG"
          string = string.magenta
        elsif severity == "INFO"
          string = string.white
        elsif severity == "WARN"
          string = string.yellow
        elsif severity == "ERROR"
          string = string.red
        elsif severity == "FATAL"
          string = string.red.bold
        end

        [string, second].join("")
      end

      @@log
    end
  end

  Fastlane::Actions.load_default_actions

  if Fastlane::FastlaneFolder.path
    actions_path = File.join(Fastlane::FastlaneFolder.path, 'actions')
    Fastlane::Actions.load_external_actions(actions_path) if File.directory?(actions_path)
  end
end
