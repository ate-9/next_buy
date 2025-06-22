class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string     :name, null: false
      t.string     :price
      t.boolean    :bought, null: false, default: false
      t.text       :memo
      # 下記は外部キー
      t.references :list, foreign_key: true, null: false

      t.timestamps
    end
  end
end
