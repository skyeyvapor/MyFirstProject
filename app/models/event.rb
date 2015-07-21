class Event < ActiveRecord::Base
validates_presence_of :title, :date, :description
	#validates_uniqueness_of :title
	has_many :comments, :dependent => :destroy
end
