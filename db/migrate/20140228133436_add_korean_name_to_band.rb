class AddKoreanNameToBand < ActiveRecord::Migration
  def change
    add_column :bands, :korean_name, :string
  end
end
