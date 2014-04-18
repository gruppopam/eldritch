require 'spec_helper'
require 'eldritch/refinements/thread'

using Eldritch::Refinements

describe Thread do
  let(:thread) { Thread.new {} }

  it 'should have together accessor' do
    # refinements don't work with #respond_to? and send, we have to check for errors
    expect{thread.together}.not_to raise_error
    expect{thread.together = nil}.not_to raise_error
  end

  it 'should have a task accessor' do
    # refinements don't work with #respond_to? and send, we have to check for errors
    expect{thread.task}.not_to raise_error
    expect{thread.task = nil}.not_to raise_error
  end

  describe '#together' do
    it 'should return the togther previously set' do
      together = double('together')
      thread.together = together
      expect(thread.together).to eql(together)
    end

    it 'should return a NilTogether when none are set' do
      expect(thread.together).to be_a Eldritch::NilTogether
    end
  end

  describe '#together?' do
    it 'should be false when together is nil' do
      thread.together = nil
      expect(thread.together?).to be_false
    end

    it 'should be false when together is a NilTogether' do
      thread.together = Eldritch::NilTogether.new
      expect(thread.together?).to be_false
    end

    it 'should be true when together is set' do
      thread.together = 2
      expect(thread.together?).to be_true
    end
  end
end