class AddLatitudeLongitudeFromCidades < ActiveRecord::Migration
  def change
    add_column :cidades, :latitude, :float,default: 0.6123044764332252
    add_column :cidades, :longitude, :float,default: -51.3437641853028
  end
end
