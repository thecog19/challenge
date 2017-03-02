class CreateScrubs < ActiveRecord::Migration[5.0]
  def change
    create_table :scrubs do |t|

      t.timestamps
    end
  end
end
