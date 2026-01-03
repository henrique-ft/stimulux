# frozen_string_literal: true

def div(**props)
  puts props.inspect
end

class String
  def to_snake_case
    # Handle acronyms (e.g., 'CNN', 'ISO', 'RESTfulAPI')
    # This first gsub handles cases like "CNNNews" -> "cnn_news" or "RESTfulAPI" -> "restful_api"
    s = gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')

    # Handle standard camelCase (e.g., "camelCase" -> "camel_case")
    # This second gsub handles internal capital letters
    s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
  end
end

def string_to_data(str)
  str.to_s.to_snake_case.gsub('_', '-')
end

def controller(name, props = nil)
  { 'data-controller' => name }

  props
end

def value(controller_name, target_name)
  { "data-#{string_to_data(controller_name)}-target" => target_name }
end

def target(controller_name, target_name)
  { "data-#{string_to_data(controller_name)}-target" => target_name }
end

def set_value(controller_name, target_name)
  { "data-#{string_to_data(controller_name)}-value" => target_name }
end

def on_action(controller_name, method_name, type: nil)
  return { 'data-action' => "#{controller_name}##{method_name}" } unless type

  { 'data-action' => "#{type}->#{controller_name}##{method_name}" }
end

div oi: 3, **controller('userProfile', { 'userId' => 24 }), **target('tchal', 'something')
div oi: 3, **on_action('userProfile', 'myMethod', type: 'clipboard:copy')
div(oi: 3, **on_actions(['userProfile', 'myMethod', { type: 'clipboard:copy' }]))
div oi: 3, **target('userProfile', 'myTarget')
div oi: 3, **set_value('userProfile', 'myValue')

form(**controller('userProfile', 'anotherController')) do
  input(**target('userProfile', 'name'))

  button class: 'p', **on_action('userProfile', 'do').merge(on_action)
end

# // hello_controller.js
# import { Controller } from "stimulus"

# export default class extends Controller {
# static targets = [ "name", "output" ]

# greet() {
# this.outputTarget.textContent =
# `Hello, ${this.nameTarget.value}!`
# }
# }

include Stimulux

def stimulus
  Stimulux
end

# data-controller='hello foo-bar' data-foo-bar-some-thing-value='x'
form(**controllers('hello', ['foo-bar', { 'someThing' => 'x' }]),
**classes(['foo-bar', { 'noResults' => 'bg-gray-500' }])) do
  # data-hello-target='name' # data-foo-bar-target='baz'
  input data: { index: 'oi' }, **targets('hello#name', 'foo-bar#baz')
  # button class: 'p', data: { hello: { target: 'name'}, 'foo-bar': { target: 'baz' } }
  # button class: 'p', 'data-hello-target':'name', 'data-foo-bar-target':'baz'

  # data-action='hello#greet foo-bar#doSomething'
  button class: 'p', **actions('hello#greet', 'foo-bar#doSomething')
  # button class: 'p', data: { action: 'hello#greet foo-bar#doSomething' }

  # data-hello-target='output'
  span(**targets('hello#output', 'user#name'))
  # span data: { hello: { target: 'output' } }
  # span 'data-hello-target': 'output'

  div(**controllers(['content-loader', { url: 'messages.html' }]))
  # div 'data-controller': 'content-loader', 'data-content-loader-url-value': 'messages.html'
end
