Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :encrypted_password, String

      add_unique_constraint :email
      add_index :email
    end
  end
end
