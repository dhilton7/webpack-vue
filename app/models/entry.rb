class Entry < ActiveRecord::Base
  belongs_to :entry_category
  belongs_to :property
  belongs_to :sheet

  validates :amount, :account, :paid, :date, presence: true 

  delegate :address_string, to: :property

  def self.entries_for_sheet(sheet_id)
    Entry.joins(:entry_category, :property).where(sheet_id: sheet_id)
         .select('entries.*, entry_categories.name category_name, entry_categories.debt debit, properties.address')
         .order('entries.created_at desc')
  end

  def category_name
    self[:category_name] || entry_category.name
  end

  def address_string
    self[:address] || property.address_string
  end

  def debit
    self[:debit] ? self[:debit] == 't' : entry_category.debt
  end
end
