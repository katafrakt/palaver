ROM::SQL.migration do
  change do
    add_column :profiles, :avatar_data, :jsonb
  end
end