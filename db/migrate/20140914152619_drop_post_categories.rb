class DropPostCategories < ActiveRecord::Migration
  def change
    drop_table :post_categories
  end
end
