class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :list_name, null: false
      t.datetime   :due_date
      t.string     :store
      t.text       :memo
      t.boolean    :draft, null: false, default: false
      # 下記は外部キー
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :buyer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
