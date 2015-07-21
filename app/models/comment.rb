class Comment < ActiveRecord::Base
	validates_presence_of :event_id, :details, :author
	belongs_to :event
end
