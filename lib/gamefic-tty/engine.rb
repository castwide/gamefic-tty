module Gamefic
  module Tty
    class Engine
      attr_reader :plot
      attr_reader :user
      attr_reader :character

      def initialize(plot: Gamefic::Plot.new, user: Gamefic::Tty::User.new)
        @plot = plot
        @user = user
        @character = @plot.get_player_character
        @plot.introduce @character
      end

      def run
        turn until @character.concluded?
        @user.update @character.state
      end

      def self.run **args
        engine = new(**args)
        engine.run
        engine
      end

      def turn
        @plot.ready
        send_and_receive
        @plot.update
      end

      private

      def send_and_receive
        @user.update @character.state
        return if @character.concluded?
        input = @user.query("#{@character.state[:prompt]} ")
        @character.queue.push input unless input.nil?
      end
    end
  end
end
