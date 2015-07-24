#$rails generate scaffold Comment event_id:integer details:text author:string 產生controller, model, view
#$rake db:migrate
#用rails console觀察>events_list = Event.all
#>my_comment = Event.first.comments 看到的確有comment associate with that event
#
class Comment < ActiveRecord::Base
	validates_presence_of :event_id, :details, :author
	belongs_to :event
end
