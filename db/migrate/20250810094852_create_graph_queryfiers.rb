class CreateGraphQueryfiers < ActiveRecord::Migration[8.0]
  def change
    create_table :graph_queryfiers do |t|
      t.string :entity_type
      t.string :desc
      t.string :cypher_dynamic_query
      t.json :meta_data_swagger_docs
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
