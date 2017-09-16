class Entry < ActiveRecord::Base
	belongs_to :entry_category
	belongs_to :property
	belongs_to :sheet
end
