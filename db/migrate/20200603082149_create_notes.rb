class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :message
      t.timestamp :received_at
      t.references :user, index: true
      t.timestamps
    end
  end
end
