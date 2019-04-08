module Gamefic
  module Tty
    # Extend Gamefic::Engine to connect with User::Tty, which provides ANSI
    # formatting for HTML.
    #
    # @note Due to their dependency on io/console, User::Tty and Engine::Tty are
    #   not included in the core Gamefic library. `require gamefic/tty` if you
    #   need them.
    #
    class Engine < Gamefic::Engine
      def post_initialize
        self.user_class = Gamefic::Tty::User
      end

      def self.start plot
        engine = self.new(plot)
        engine.connect
        engine.run
      end

      def self.run
        self.new(Gamefic::Plot.new).run
      end
    end
  end
end
