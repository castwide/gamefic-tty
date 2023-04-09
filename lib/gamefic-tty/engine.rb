module Gamefic
  module Tty
    # A simple engine for running turn-based, single-character Gamefic plots.
    #
    class Engine
      # @return [Plot]
      attr_reader :plot

      # @return [User]
      attr_reader :user

      # @return [Character]
      attr_reader :character

      # @param plot [Plot]
      # @param user [User]
      def initialize(plot: Gamefic::Plot.new, user: Gamefic::Tty::User.new)
        @plot = plot
        @user = user
        @character = @plot.make_player_character
        @plot.introduce @character
        @plot.ready
      end

      # Run the plot to its conclusion.
      #
      def run
        turn until @plot.concluding?
        @user.update @character.output
      end

      # Create an engine and run the plot.
      #
      # @param plot [Plot]
      # @param user [User]
      # @return [Engine]
      def self.run(plot: Gamefic::Plot.new, user: Gamefic::Tty::User.new)
        engine = new(plot: plot, user: user)
        engine.run
        engine
      end

      # Run a single turn.
      #
      def turn
        send_and_receive
        @plot.update
        @plot.ready
      end

      private

      def send_and_receive
        @user.update @character.output
        return unless @character.queue.empty?

        @character.queue.push @user.query("#{@character.output[:prompt]} ")
      end
    end
  end
end
