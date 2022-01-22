class CreateDatos < ActiveRecord::Migration[7.0]
  def change
    create_table :datos do |t|
      t.string :dato1

      t.timestamps
    end
  end
end
