class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
