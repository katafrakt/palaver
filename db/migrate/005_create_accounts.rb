ROM::SQL.migration do
  change do
    create_table(:accounts) do
      primary_key(:id)
      column :email, String, null: false, unique: true
      column :password_hash, String
      column :confirmation_token, String
      column :confirmed_at, DateTime
      column :registered_at, DateTime
    end

    alter_table(:profiles) do
      add_column(:account_id, Integer)
    end
  end
end
