RSpec.describe Gamefic::Tty::Engine do
  let(:plot) {
    plot = Gamefic::Plot.new
    plot.stage do
      respond :quit do |actor|
        actor.tell 'Player quit'
        actor.conclude default_conclusion
      end
    end
    plot
  }

  let(:quitter) {
    double(Gamefic::Tty::User, query: 'quit', update: nil)
  }

  it 'completes a turn' do
    engine = Gamefic::Tty::Engine.new(plot: plot, user: quitter)
    engine.turn
    expect(engine.character).to be_concluded
  end

  it 'runs until concluded' do
    engine = Gamefic::Tty::Engine.new(plot: plot, user: quitter)
    engine.run
    expect(engine.character).to be_concluded
  end

  it 'updates after conclusion' do
    user = Gamefic::Tty::User.new(input: StringIO.new('quit'), output: StringIO.new)
    engine = Gamefic::Tty::Engine.new(plot: plot, user: user)
    engine.run
    expect(user.output.string).to include('Player quit')
  end
end
