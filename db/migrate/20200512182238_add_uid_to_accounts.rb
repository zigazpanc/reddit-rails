class AddUidToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :uid, :string, limit: 500, default: "", null: false
  end
end
