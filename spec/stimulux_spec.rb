# frozen_string_literal: true

RSpec.describe Stimulux do
  include Stimulux

  it 'has a version number' do
    expect(Stimulux::VERSION).not_to be nil
  end

  describe '#controllers' do
    it 'returns controller data attributes' do
      expected = { 'data-controller' => 'hello foo-bar', 'data-foo-bar-some-thing-value' => 'xpto' }
      expect(controllers('hello', ['foo_bar', { 'someThing' => 'xpto' }])).to eq(expected)
    end

    it 'handles only names' do
      expected = { 'data-controller' => 'hello world' }
      expect(controllers('hello', 'world')).to eq(expected)
    end

    it 'handles values for multiple controllers' do
      expected = {
        'data-controller' => 'c1 c2',
        'data-c1-my-value-value' => '1',
        'data-c2-other-value-value' => '2'
      }
      expect(controllers(['c1', { myValue: '1' }], ['c2', { other_value: '2' }])).to eq(expected)
    end
  end

  describe '#targets' do
    it 'returns target data attributes' do
      expected = { 'data-hello-target' => 'name', 'data-foo-bar-target' => 'baz' }
      expect(targets('hello#name', 'foo-bar#baz')).to eq(expected)
    end

    it 'returns target data attributes' do
      expected = { 'data-hello-target' => 'myName', 'data-foo-bar-target' => 'baz' }
      expect(targets('hello#myName', 'foo-bar#baz')).to eq(expected)
    end
  end

  describe '#actions' do
    it 'returns action data attributes' do
      expected = { 'data-action' => 'hello#greet foo-bar#doSomething' }
      expect(actions('hello#greet', 'foo-bar#doSomething')).to eq(expected)
    end
  end

  describe '#classes' do
    it 'returns class data attributes' do
      expected = {
        'data-foo-bar-no-results-class' => 'bg-gray-500',
        'data-gee-loading-class' => 'bg-gray-200'
      }
      expect(classes(['foo_bar', { 'noResults' => 'bg-gray-500' }],
                     ['gee', { 'loading' => 'bg-gray-200' }])).to eq(expected)
    end
  end
end
