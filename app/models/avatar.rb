class Avatar < ActiveRecord::Base

  DEFAULT_SIZE = 50

  validates_presence_of :email
  validates_uniqueness_of :email

  image_accessor :avatar

  before_save :set_checksum

  def self.dimensions(size = Avatar::DEFAULT_SIZE)
    "#{size.to_s}x#{size.to_s}"
  end

  def set_checksum
    self.checksum = Digest::MD5.hexdigest(email)
  end

  def to_param
    checksum
  end
end
