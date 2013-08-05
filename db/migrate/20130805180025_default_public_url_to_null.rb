class DefaultPublicUrlToNull < ActiveRecord::Migration
  def change
  	change_column :locations, :public_url, :string, :default => nil
  end
end
