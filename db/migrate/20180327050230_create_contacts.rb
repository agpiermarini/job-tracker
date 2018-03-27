class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :role
      t.string :email
      t.references :companies, foreign_key: true, index: true

      t.timestamps
    end
  end
end
