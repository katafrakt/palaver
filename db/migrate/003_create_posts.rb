ROM::SQL.migration do
  change do
    create_table(:posts) do
      primary_key :id
      foreign_key :topic_id, :topics
      column :text, String
    end
  end
end
