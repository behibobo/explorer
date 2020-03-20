class User < ApplicationRecord
  #Validations
  validates_presence_of :mobile
  validates :mobile, uniqueness: true

  before_create :generate_activation_code

  #encrypt password
  has_secure_password

  belongs_to :city, optional: true
  def full_name
     "#{self.first_name} #{self.last_name}"
  end

  def generate_activation_code
    self.activation_code = rand(9999999).to_s.center(6, rand(9).to_s)
  end
end
