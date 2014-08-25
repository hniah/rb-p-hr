class CollectionSizeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if options[:maximum] && value.size >= options[:maximum]
      record.errors[attribute] << (options[:message] || "must have at most #{options[:maximum]} records.")
    end

    if options[:minimum] && value.size <= options[:minimum]
      record.errors[attribute] << (options[:message] || "must have at lease #{options[:minimum]} records.")
    end
  end
end

class Staff < User
  has_many :leaves
  has_many :lates
  has_many :feedbacks

  validates :lates, collection_size: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }
end

