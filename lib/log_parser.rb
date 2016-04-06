require 'time'
require "log_parser/version"

str1 = "I, [2016-04-06T22:08:15.226723 #2303]  INFO -- : aaaaaaaaa"
str2 = "I, [2016-04-06T22:09:05.992304 #2303]  INFO -- hoge: aaaaaaaaa"

module LogParser
  class Parser
    attr_reader :level, :date, :pid, :level_full, :progname, :message
    def initialize(log_message)
      @log_message = log_message
    end

    def parse!
      @log_message.match(%r!\A(?<level>\w), \[(?<date_str>.+)\s#(?<pid>\d+)\]\s+(?<level_full>\w+)\s+--\s(?<progname>\w*?):\s(?<message>.+)\z!) do |matched|
        @level = matched[:level]
        @date = Time.parse(matched[:date_str])
        @pid = matched[:pid]
        @level_full = matched[:level_full]
        @progname = matched[:progname]
        @message = matched[:message]
      end
    end

    def self.parse!(log_message)
      parser = new(log_message)
      parser.parse!
      parser
    end
  end
end
