class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :uuid
      t.string :platform
      t.references :user, index: true

      t.timestamps
    end
  end
end
