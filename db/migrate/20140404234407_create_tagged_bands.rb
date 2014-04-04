class CreateTaggedBands < ActiveRecord::Migration
  def change
    create_table :tagged_bands do |t|
      t.references :band, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
