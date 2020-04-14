class User < ApplicationRecord
  #Validations
  validates_presence_of :mobile
  validates :mobile, uniqueness: true

  belongs_to :city, optional: true
  belongs_to :state, optional: true
  has_many :item_codes
  has_many :items, through: :item_codes
  has_many :user_treasures, dependent: :destroy
  has_many :user_loplobs, dependent: :destroy
  has_many :purchased_loplobs, dependent: :destroy
  has_many :found_treasures, dependent: :destroy

  def age
    Date.today.year - self.dob.to_date.year
  end

  def self.this_month(day, state_id = nil)
    users = User.all
    users = users.where(state_id: state_id) unless state_id.nil?
    users.select {|u| u.created_at.to_date.to_pdate.month == Time.now.to_date.to_pdate.month and u.created_at.to_date.to_pdate.day == day }.count
  end

  def self.last_month(day, state_id = nil)
    users = User.all
    users = users.where(state_id: state_id) unless state_id.nil?
    if Time.now.to_date.to_pdate.month == 1
      users.select {|u| u.created_at.to_date.to_pdate.month == 12 and u.created_at.to_date.to_pdate.day == day}.count
    else
      users.select {|u| u.created_at.to_date.to_pdate.month == (Time.now.to_date.to_pdate.month) - 1 and u.created_at.to_date.to_pdate.day == day}.count
    end
  end


  def full_name
     "#{self.first_name} #{self.last_name}"
  end

  def self.starts_with(column_name, prefix)
    where("lower(#{column_name}) like ?", "#{prefix.downcase}%")
    .order(:last_name)
    .order(:first_name)
  end
end
