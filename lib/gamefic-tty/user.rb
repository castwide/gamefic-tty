require 'json'
require 'html_to_ansi'

module Gamefic
  module Tty
    # An interface for passing IO between an engine and a client.
    #
    class User
      # @return [IO]
      attr_reader :input

      # @return [IO]
      attr_reader :output

      # @param input [IO] The stream that receives input
      # @param output [IO] The stream that sends output
      def initialize input: STDIN, output: STDOUT
        @input = input
        @output = output
      end

      # Update the user with a hash of data representing the current game state.
      #
      # @param state [Hash]
      # @return [void]
      def update state
        @output.write state_to_text(state)
      end

      def state_to_text state
        output = state[:messages].to_s
        unless state[:options].nil?
          list = '<ol class="multiple_choice">'
          state[:options].each { |o|
            list += "<li><a href=\"#\" rel=\"gamefic\" data-command=\"#{o}\">#{o}</a></li>"
          }
          list += "</ol>"
          output += list
        end
        HtmlToAnsi.convert output
      end

      # Get input from the user.
      #
      # @return [String, nil]
      def query prompt = '> '
        @output.print prompt
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
