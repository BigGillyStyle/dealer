class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :images do |t|
      t.timestamps null: false
    end
  end
end
