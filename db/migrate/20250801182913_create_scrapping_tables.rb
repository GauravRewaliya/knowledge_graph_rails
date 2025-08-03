class CreateScrappingTables < ActiveRecord::Migration[8.0]
  def change
    create_table :scrapping_tables do |t|
      t.string :source_type_key
      t.string :url
      t.jsonb :request
      t.jsonb :response
      t.jsonb :filterer_json
      t.text :conveter_code
      t.jsonb :final_clean_response
      t.integer :processing_status
      t.references :workspace, null: false, foreign_key: true
      # t.jsonb :temp_response
      # t.json :meta_data
      # add_column :scrapper_dbs, :clean_response, :json
      # add_column :scrapper_dbs, :clean_response_filter, :json
  
      t.timestamps
    end
  end
end
