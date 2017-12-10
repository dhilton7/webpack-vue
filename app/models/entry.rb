class Entry < ActiveRecord::Base
	belongs_to :entry_category
	belongs_to :property
	belongs_to :sheet

	validates :amount, :account, :paid, :date, presence: true
end
