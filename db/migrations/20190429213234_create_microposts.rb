Hanami::Model.migration do
  change do
    create_table :microposts do
      primary_key :id

      column :content, String, null: false

      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
