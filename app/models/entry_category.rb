class EntryCategory < ActiveRecord::Base
  def self.all_select
    EntryCategory.all.select('id, name')
  end
end
