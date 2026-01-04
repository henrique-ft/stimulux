# frozen_string_literal: true

# gem install html_slice
# gem install phlex

require 'html_slice'
require 'phlex'
# require 'stimulux'

require_relative '../lib/stimulux'

class MyPage
  include HtmlSlice
  include Stimulux
end

# frozen_string_literal: true

require 'benchmark'
require 'byebug'
require 'phlex/version'

CALLS_NUMBER = 10
TAGS_NUMBER = 1000

class RunRawPhlex < Phlex::HTML
  def initialize(text = 'Benchmark')
    @text = text
  end

  def view_template
    div do
      (0..TAGS_NUMBER).each do |i|
        h1(style: "a#{i}", id: i, class: 'c', role: 'd', a_attribute: 'something') { @text }
        div 'data-controller': 'searchName', 'data-search-name-name-value': "a#{i}" do
          input type: 'text', 'data-search-name-target': 'some'
        end
      end
    end
  end
end

class RunPhlex < Phlex::HTML
  include Stimulux

  def initialize(text = 'Benchmark')
    @text = text
  end

  def view_template
    div do
      (0..TAGS_NUMBER).each do |i|
        h1(style: "a#{i}", id: i, class: 'c', role: 'd', a_attribute: 'something') { @text }
        div(**stimulus_controller(['searchName', { name: "a#{i}" }])) do
          input type: 'text', **stimulus_target('searchName#some')
        end
      end
    end
  end
end

class RunRawHtmlSlice
  include HtmlSlice

  def initialize(text = 'Benchmark')
    @text = text
  end

  def call
    html_slice do
      div do
        (0..TAGS_NUMBER).each do |i|
          h1 @text, style: "a#{i}", id: i, class: 'c', role: 'd', a_attribute: 'something'
          div 'data-controller': 'searchName', 'data-search-name-name-value': "a#{i}" do
            input type: 'text', 'data-search-name-target': 'some'
          end
        end
      end
    end
  end
end

class RunHtmlSlice
  include HtmlSlice
  include Stimulux

  def initialize(text = 'Benchmark')
    @text = text
  end

  def call
    html_slice do
      div do
        (0..TAGS_NUMBER).each do |i|
          h1 @text, style: "a#{i}", id: i, class: 'c', role: 'd', a_attribute: 'something'
          div(**stimulus_controller(['searchName', { name: "a#{i}" }])) do
            input type: 'text', **stimulus_target('searchName#some')
          end
        end
      end
    end
  end
end

Benchmark.bm do |x|
  x.report("raw phlex v#{Phlex::VERSION}") do
    CALLS_NUMBER.times { |count| RunRawPhlex.new("Benchmark #{count}").call }
  end

  x.report("phlex v#{Phlex::VERSION} using stimulux") do
    CALLS_NUMBER.times { |count| RunPhlex.new("Benchmark #{count}").call }
  end

  x.report("raw html_slice v#{HtmlSlice::VERSION}") do
    CALLS_NUMBER.times { |count| RunRawHtmlSlice.new("Benchmark #{count}").call }
  end

  x.report("html_slice v#{HtmlSlice::VERSION} using stimulux") do
    CALLS_NUMBER.times { |count| RunHtmlSlice.new("Benchmark #{count}").call }
  end
end
