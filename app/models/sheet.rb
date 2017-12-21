class Sheet < ApplicationRecord
  has_many :entries

	def self.details_for(id)
    Sheet.joins(:entries)
         .preload(:entries)
         .joins('inner join entry_categories on entries.entry_category_id = entry_categories.id')
         .order('year desc, title asc, entries.date desc')
         .where(id: id).first
	end
end
