class Entry < ActiveRecord::Base
  belongs_to :entry_category
  belongs_to :property
  belongs_to :sheet

  validates :amount, :account, :paid, :date, presence: true 

  delegate :address_string, to: :property

  def category_name
    self[:category_name] || entry_category.name
  end

  def debit
    self[:debit] || entry_category.debt
  end
end
