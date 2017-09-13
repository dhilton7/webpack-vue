class Property < ActiveRecord::Base
  belongs_to :user

  def address_string
    [address, "#{city},", state, zip].compact.join(' ')
  end

  def to_builder
    Jbuilder.new do |property|
      property.(self, :address, :city, :state, :zip, :status, :notes)
    end
  end

end