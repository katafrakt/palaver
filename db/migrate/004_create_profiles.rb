ROM::SQL.migration do
  change do
    create_table(:profiles) do
      primary_key :id
      column :nickname, String
    end

    alter_table(:messages) do
      add_foreign_key(:author_id, :profiles)
    end
  end
end
