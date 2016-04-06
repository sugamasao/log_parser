require 'spec_helper'

describe LogParser do
  context 'log parse' do
    let(:log) { 'I, [2016-04-06T22:00:00.226723 #2303]  INFO -- : message' }
    subject(:parser) { LogParser::Parser.parse!(log) }
    it do
      expect(parser.level).to eq 'I'
      expect(parser.date.hour).to eq 22
      expect(parser.pid).to eq '2303'
      expect(parser.level_full).to eq 'INFO'
      expect(parser.progname).to eq ''
      expect(parser.message).to eq 'message'
    end
  end

  context 'log parse with progname' do
    let(:log) { 'I, [2016-04-06T22:00:00.226723 #2303]  INFO -- prog: message' }
    subject(:parser) { LogParser::Parser.parse!(log) }
    it do
      expect(parser.level).to eq 'I'
      expect(parser.date.hour).to eq 22
      expect(parser.pid).to eq '2303'
      expect(parser.level_full).to eq 'INFO'
      expect(parser.progname).to eq 'prog'
      expect(parser.message).to eq 'message'
    end
  end
end
