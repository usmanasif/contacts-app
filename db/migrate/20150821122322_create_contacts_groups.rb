class CreateContactsGroups < ActiveRecord::Migration
  def change
    create_table :contacts_groups do |t|
      t.references :contact, index: true
      t.references :group, index: true

      t.timestamps null: false
    end

    add_index :contacts_groups, [:contact_id, :group_id], unique: true
  end
end
