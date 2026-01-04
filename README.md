![Stimulux](https://raw.githubusercontent.com/henrique-ft/stimulux/main/stimulux-logo.png)

# Stimulux

Welcome to Stimulux! This gem provides a set of helpers to simplify the integration of Stimulus JS with [Phlex](https://www.phlex.fun/) and [HtmlSlice](https://github.com/henrique-ft/html_slice) components, focusing on generating the necessary `data-*` attributes with ease and precision.

The goal is to improve productivity and legibility while working with Stimulus inside Ruby html generation gems.

```ruby
# ... inside our component
include Stimulux

# data-controller="hello other" data-other-some-thing-value="hey"
div **controllers('hello', ['other', { someThing: "hey" }]) do

  # data-other-no-results-class='bg-gray-500'
  div **classes(['other', { 'noResults' => 'bg-gray-500' }]) do
  
    # data-hello-target="name" data-other-target="ho"
    input type: 'text', **targets('hello#name', 'other#ho')
    
    # data-action="click->hello#greet"
    button **actions('click->hello#greet')
    
    # data-hello-target="output"  data-other-target="letsGo"
    span **targets('hello#output', 'other#letsGo')
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stimulux'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install stimulux
```

## Usage

Stimulux offers a variety of helpers to generate `data-*` attributes for Stimulus controllers, actions, targets, and classes.

### `controllers(*args)`

This helper generates the `data-controller` attribute, along with any specified `data-` values. You can pass multiple controller names as strings or symbols. To pass values, you can use a hash with the controller name as the key.

**Simple Controller:**

```ruby
Stimulux.controllers('my-controller')
# => { 'data-controller' => 'my-controller' }
```

**Multiple Controllers:**

```ruby
Stimulux.controllers('controller-one', 'controller-two')
# => { 'data-controller' => 'controller-one controller-two' }
```

**Controller with Values:**

When you need to pass values to a Stimulus controller, you can use an array where the first element is the controller's name and the second is a hash of values.

```ruby
Stimulux.controllers(['my-controller', { url: '/path', count: 1 }])
# => {
#      'data-controller' => 'my-controller',
#      'data-my-controller-url-value' => '/path',
#      'data-my-controller-count-value' => 1
#    }
```

**Combining Multiple Controllers and Values:**

```ruby
Stimulux.controllers('controller-one', ['my-controller', { url: '/path', count: 1 }])
# => {
#      'data-controller' => 'controller-one my-controller',
#      'data-my-controller-url-value' => '/path',
#      'data-my-controller-count-value' => 1
#    }
```

### `actions(*names)`

This helper generates the `data-action` attribute. You can pass multiple action strings.

```ruby
Stimulux.actions('click->my-controller#action')
# => { 'data-action' => 'click->my-controller#action' }
```

**Multiple Actions:**

```ruby
Stimulux.actions('click->my-controller#action', 'mouseover->my-controller#anotherAction')
# => { 'data-action' => 'click->my-controller#action mouseover->my-controller#anotherAction' }
```

### `targets(*names)`

This helper generates `data-` target attributes. The target name should be in the format `controller-name#target-name`.

```ruby
Stimulux.targets('my-controller#my-target')
# => { 'data-my-controller-target' => 'my-target' }
```

**Multiple Targets for the same controller:**

```ruby
Stimulux.targets('my-controller#target-one', 'my-controller#target-two')
# => { 'data-my-controller-target' => 'target-one target-two' }
```

**Multiple Targets for different controllers:**

```ruby
Stimulux.targets('my-controller#target-one', 'another-controller#target-two')
# => {
#      'data-my-controller-target' => 'target-one',
#      'data-another-controller-target' => 'target-two'
#    }
```

### `classes(*definitions)`

This helper generates `data-` class attributes. It takes a hash where the keys are controller names and the values are hashes of class mappings.

```ruby
Stimulux.classes(
  'my-controller' => {
    loading: 'is-loading',
    loaded: 'is-loaded'
  }
)
# => {
#      'data-my-controller-loading-class' => 'is-loading',
#      'data-my-controller-loaded-class' => 'is-loaded'
#    }
```

**Multiple Controllers with Classes:**

```ruby
Stimulux.classes(
  'my-controller' => {
    loading: 'is-loading',
    loaded: 'is-loaded'
  },
  'another-controller' => {
    active: 'is-active'
  }
)
# => {
#      'data-my-controller-loading-class' => 'is-loading',
#      'data-my-controller-loaded-class' => 'is-loaded',
#      'data-another-controller-active-class' => 'is-active'
#    }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/henrique-ft/stimulux.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
