# frozen_string_literal: true

require_relative 'stimulux/version'

module Stimulux
  extend self

  def controllers(*args)
    controller_names = []
    value_attributes = {}

    args.each do |arg|
      case arg
      when String, Symbol
        controller_names << kebabize(arg)
      when Array
        name, values = arg
        controller_name = kebabize(name)
        controller_names << controller_name

        if values.is_a?(Hash)
          values.each do |key, value|
            value_key = "data-#{controller_name}-#{kebabize(key)}-value"
            value_attributes[value_key] = value
          end
        end
      end
    end

    { 'data-controller' => controller_names.join(' ') }.merge(value_attributes)
  end

  def targets(*names)
    targets = names.each_with_object(Hash.new { |h, k| h[k] = [] }) do |name, hash|
      controller, target_name = name.to_s.split('#')
      hash[kebabize(controller)] << target_name
    end

    targets.transform_keys { |key| "data-#{key}-target" }
           .transform_values { |value| value.join(' ') }
  end

  def actions(*names)
    { 'data-action' => names.join(' ') }
  end

  def classes(*definitions)
    definitions.each_with_object({}) do |(name, classes_hash), hash|
      controller_name = kebabize(name)
      classes_hash.each do |key, value|
        class_key = "data-#{controller_name}-#{kebabize(key)}-class"
        hash[class_key] = value
      end
    end
  end

  private

  def kebabize(str)
    return '' if str.nil? || str.empty?

    s = str.to_s

    s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
     .gsub(/([a-z\d])([A-Z])/, '\1-\2')
     .tr('_', '-')
     .downcase
  end
end
