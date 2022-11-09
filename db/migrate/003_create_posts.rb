ROM::SQL.migration do
  change do
    create_table(:posts) do
      primary_key :id
      foreign_key :topic_id, :topics
      column :text, String
    end

    alter_table(:topics) do
      add_foreign_key(:first_post_id, :posts)
      add_foreign_key(:last_post_id, :posts)
    end
  end
end
