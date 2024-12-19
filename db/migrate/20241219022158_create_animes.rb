class CreateAnimes < ActiveRecord::Migration[8.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.integer :quantity_episodes
      t.integer :status, default: 0
      t.string :sinopse

      t.timestamps
    end
  end
end
