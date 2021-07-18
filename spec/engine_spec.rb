RSpec.describe Gamefic::Tty::Engine do
  let(:plot) {
    plot = Gamefic::Plot.new
    plot.stage do
      respond :think do |actor|
        actor.tell 'Player thinks'
        actor.queue.push 'quit'
      end

      respond :quit do |actor|
        actor.tell 'Player quit'
        actor.conclude default_conclusion
      end
    end
    plot
  }

  it 'completes a turn' do
    user = Gamefic::Tty::User.new(input: StringIO.new('quit'), output: StringIO.new)
    engine = Gamefic::Tty::Engine.new(plot: plot, user: user)
    engine.turn
    expect(engine.character).to be_concluded
  end

  it 'runs until concluded' do
    user = Gamefic::Tty::User.new(input: StringIO.new('quit'), output: StringIO.new)
    engine = Gamefic::Tty::Engine.new(plot: plot, user: user)
    engine.run
    expect(engine.character).to be_concluded
  end

  it 'runs from the singleton method' do
    user = Gamefic::Tty::User.new(input: StringIO.new('quit'), output: StringIO.new)
    engine = Gamefic::Tty::Engine.run(plot: plot, user: user)
    expect(engine.character).to be_concluded
  end

  it 'handles multiple commands in queue' do
    user = Gamefic::Tty::User.new(input: StringIO.new("think"), output: StringIO.new)
    engine = Gamefic::Tty::Engine.new(plot: plot, user: user)
    engine.run
    expect(user.output.string).to include('Player thinks')
    expect(user.output.string).to include('Player quit')
  end

  it 'updates after conclusion' do
    user = Gamefic::Tty::User.new(input: StringIO.new('quit'), output: StringIO.new)
    engine = Gamefic::Tty::Engine.new(plot: plot, user: user)
    engine.run
    expect(user.output.string).to include('Player quit')
  end
end
