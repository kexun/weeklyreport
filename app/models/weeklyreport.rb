# encoding: utf-8 

class Weeklyreport < ActiveRecord::Base
  
  attr_accessible :content, :endtime, :projectid, :starttime, :author_id
  validates_presence_of :content, :endtime, :starttime
end
