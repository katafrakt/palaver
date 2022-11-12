ROM::SQL.migration do
  change do
    create_table(:messages) do
      primary_key :id
      foreign_key :thread_id, :threads
      column :text, String
    end

    alter_table(:threads) do
      add_foreign_key(:first_message_id, :messages)
      add_foreign_key(:last_message_id, :messages)
    end
  end
end
