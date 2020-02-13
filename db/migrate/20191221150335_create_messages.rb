class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.string :text
      t.references :user, type: :uuid, null: false, foreign_key: true
      # t.references :users, type: :uuid, index: true
      t.references :conversation, type: :uuid, null: false, foreign_key: true
      # t.references :conversations, type: :uuid, index: true
    end
  end
end
