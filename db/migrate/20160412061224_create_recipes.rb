class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :dishname
      t.text :protocol
      t.integer :user_id
    end
  end
end
