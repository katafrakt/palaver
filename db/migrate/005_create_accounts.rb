ROM::SQL.migration do
  change do
    create_table(:accounts) do
      primary_key(:id)
      column :email, String, null: false, unique: true
      column :crypted_password, String
      column :confirmation_token, String
      column :confirmed_at, DateTime
      column :registered_at, DateTime
    end

    alter_table(:profiles) do
      add_foreign_key(:account_id, :accounts)
    end
  end
end
