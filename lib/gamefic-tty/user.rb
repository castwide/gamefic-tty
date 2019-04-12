require 'gamefic/user'
require 'json'

module Gamefic
  module Tty
    class User
      # @param input [IO] The stream that receives input
      # @param output [IO] The stream that sends output
      def initialize input: STDIN, output: STDOUT
        @input = input
        @output = output
      end

      # Update the user with a hash of data representing the current game state.
      #
      # @param data [Hash]
      # @return [void]
      def update state
        @output.write state_to_text(state)
      end

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

      # Get input from the user.
      #
      # @return [String, nil]
      def query
        @input.gets
      end

      # @todo Save and restore aren't ready yet

      # def save filename, snapshot
      #   File.open(filename, 'w') do |file|
      #     file << snapshot.to_json
      #   end
      # end

      # def restore filename
      #   json = File.read(filename)
      #   snapshot = JSON.parse(json, symbolize_names: true)
      #   engine.restore snapshot
      # end
    end
  end
end
