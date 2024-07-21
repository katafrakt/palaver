ROM::SQL.migration do
  change do
    create_table(:categories) do
      primary_key :id
      column :name, String
      column :description, String
    end
  end
end
