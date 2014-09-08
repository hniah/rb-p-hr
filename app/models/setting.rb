class Setting < ActiveRecord::Base
  validates :key, presence: true

  attr_accessor :settings

  @@settings  = {}

  def self.[](key_name)
    return @@settings[key_name] if @@settings[key_name].present?
    object(key_name).nil? ? nil : @@settings[key_name] = object(key_name).value
  end

  def self.object(key_name)
    Setting.find_by_key(key_name.to_s)
  end

  def self.method_missing(method, *args)
    method_name = method.to_s
    super(method, *args)

  rescue NoMethodError
    if method_name =~ /=$/
      key_name = method_name.gsub('=', '')
      value = args.first
      self[key_name] = value
    else
      self[method_name]
    end
  end
end
