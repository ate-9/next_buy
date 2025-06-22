class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text   :password, null: false
      t.string :icon_color

      t.timestamps
    end
  end
end
