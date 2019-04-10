require 'gamefic/user'
require 'json'

module Gamefic
  module Tty
    class User < Gamefic::User
      def state_to_text state
        output = state[:output].to_s
        unless state[:options].nil?
          list = '<ol class="multiple_choice">'
          state[:options].each { |o|
            list += "<li><a href=\"#\" rel=\"gamefic\" data-command=\"#{o}\">#{o}</a></li>"
          }
          list += "</ol>"
          output += list
        end
        "#{Gamefic::Tty::Text::Html::Conversions.html_to_ansi output}#{state[:prompt]} "
      end

      def save filename, snapshot
        File.open(filename, 'w') do |file|
          file << snapshot.to_json
        end
      end

      def restore filename
        json = File.read(filename)
        snapshot = JSON.parse(json, symbolize_names: true)
        engine.plot.restore snapshot
      end
    end
  end
end
