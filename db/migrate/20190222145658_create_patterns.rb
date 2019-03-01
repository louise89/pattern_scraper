class CreatePatterns < ActiveRecord::Migration[5.2]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :designer
      t.string :price
      t.string :link
      t.string :picture

      t.timestamps
    end
  end
end
