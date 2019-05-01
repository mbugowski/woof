Hanami::Model.migration do
  change do
    create_table :relationships do
      primary_key :id

      foreign_key :follower_id, :users, null: false, on_delete: :cascade
      foreign_key :followed_id, :users, null: false, on_delete: :cascade
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
