ROM::SQL.migration do
  change do
    alter_table(:threads) do
      add_column(:pinned, TrueClass, null: false, default: false)
      add_column(:locked, TrueClass, null: false, default: false)
    end
  end
end
