class CreateVehicles < ActiveRecord::Migration[4.2]
  def change
    create_table :vehicles do |t|
      t.string :vin
      t.integer :year
      t.string :make
      t.string :model
      t.string :trim
      t.integer :mileage
      t.string :exterior_color
      t.string :interior_color
      t.string :transmission
      t.string :body_style
      t.string :drivetrain
      t.string :engine
      t.text :options
      t.text :comments

      t.timestamps null: false
    end
  end
end
