class Createweeklyreports < ActiveRecord::Migration
  def change
    create_table :weeklyreports do |t|
      t.date :starttime
      t.date :endtime
      t.text :content
      t.integer :projectid
      t.integer :author_id
    end
  end
end
