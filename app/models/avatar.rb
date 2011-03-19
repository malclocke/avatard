class Avatar < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  image_accessor :avatar

  before_save :set_checksum

  def set_checksum
    self.checksum = Digest::MD5.hexdigest(email)
  end

  def to_param
    checksum
  end
end
