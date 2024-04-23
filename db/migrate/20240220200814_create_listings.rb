class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.string :status,  default: "Unverified"
      t.string :category, null: false
      t.string :size, null: false
      t.string :brand
      t.string :color
      t.boolean :new_with_tags, default: false
      t.string :style_tags, array: true, default: []
      t.string :style
      t.boolean :sell, default: false
      t.boolean :rent, default: false
      t.decimal :original_price
      t.decimal :listing_price
      t.decimal :rental_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
