class CreateMessages < Dynomite::Migration
  def up
    create_table :messages do |t|
      t.partition_key :id
      t.add_gsi :updated_at
    end
  end
end

# More examples: https://rubyonjets.com/docs/database/dynamodb/migration/
