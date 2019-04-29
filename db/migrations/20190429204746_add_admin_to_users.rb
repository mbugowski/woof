Hanami::Model.migration do
  change do
    add_column :users, :admin, FalseClass, default: false
  end
end
