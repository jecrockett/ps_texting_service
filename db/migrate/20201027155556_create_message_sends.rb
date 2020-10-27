class CreateMessageSends < ActiveRecord::Migration[6.0]
  def change
    create_table :message_sends do |t|
      t.references :message, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true
      t.string :provider_message_id, index: true
      t.string :status
      t.timestamp :status_updated_at

      t.timestamps
    end
  end
end
