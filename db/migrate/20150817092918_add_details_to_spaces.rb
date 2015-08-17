class AddDetailsToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :views, :integer
  end
end
