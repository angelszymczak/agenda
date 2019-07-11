class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :description, null: false
      t.references :contact, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
