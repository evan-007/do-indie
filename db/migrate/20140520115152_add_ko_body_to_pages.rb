class AddKoBodyToPages < ActiveRecord::Migration
  def change
    add_column :pages, :ko_body, :text
  end
end
