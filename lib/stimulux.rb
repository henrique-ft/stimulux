# frozen_string_literal: true

require_relative "stimulux/version"

module Stimulux
  extend self

  def controllers(*args)
    @controllers_cache ||= {}
    return @controllers_cache[args] if @controllers_cache.key?(args)

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

    @controllers_cache[args] = { "data-controller" => controller_names.join(" ") }.merge(value_attributes)
  end

  def targets(*names)
    @targets_cache ||= {}
    return @targets_cache[names] if @targets_cache.key?(names)

    @targets_cache[names] = names.each_with_object({}) do |name, hash|
      controller, target_name = name.to_s.split("#")
      hash["data-#{kebabize(controller)}-target"] = target_name
    end
  end

  def actions(*names)
    @actions_cache ||= {}
    return @actions_cache[names] if @actions_cache.key?(names)

    @actions_cache[names] = { "data-action" => names.join(" ") }
  end

  def classes(*definitions)
    @classes_cache ||= {}
    return @classes_cache[definitions] if @classes_cache.key?(definitions)

    @classes_cache[definitions] = definitions.each_with_object({}) do |(name, classes_hash), hash|
      controller_name = kebabize(name)
      classes_hash.each do |key, value|
        class_key = "data-#{controller_name}-#{kebabize(key)}-class"
        hash[class_key] = value
      end
    end
  end

  private

  def kebabize(str)
    @kebabize_cache ||= {}
    return "" if str.nil? || str.empty?
    s = str.to_s
    return @kebabize_cache[s] if @kebabize_cache.key?(s)

    @kebabize_cache[s] = s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
                         .gsub(/([a-z\d])([A-Z])/, '\1-\2')
                         .tr("_", "-")
                         .downcase
  end
end
