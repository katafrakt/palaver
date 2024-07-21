ROM::SQL.migration do
  change do
    create_table(:threads) do
      primary_key :id
      foreign_key :category_id, :categories
      column :title, String
    end

    alter_table(:categories) do
      add_foreign_key(:latest_thread_id, :threads)
    end
  end
end
