require 'stringio'

RSpec.describe Gamefic::Tty::User do
  it 'writes output on update' do
    output = StringIO.new
    user = Gamefic::Tty::User.new(output: output)
    user.update({
      output: '<p>Test</p>'
    })
    expect(output.string).to include('Test')
  end

  it 'reads input on query' do
    input = StringIO.new('test')
    user = Gamefic::Tty::User.new(input: input, output: StringIO.new)
    result = user.query
    expect(result).to eq('test')
  end

  it 'adds options to output' do
    output = StringIO.new
    user = Gamefic::Tty::User.new(output: output)
    user.update({
      options: ['one', 'two']
    })
    expect(output.string).to include('one', 'two')
  end
end
