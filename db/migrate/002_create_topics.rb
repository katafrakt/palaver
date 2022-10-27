ROM::SQL.migration do
  change do
    create_table(:topics) do
      primary_key :id
      foreign_key :category_id, :categories
      column :title, String
    end
  end
end
