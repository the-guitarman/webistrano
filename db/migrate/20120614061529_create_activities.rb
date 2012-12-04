class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :target_type
      t.string :tag
      t.text :data

      t.timestamps
    end
  end
end
