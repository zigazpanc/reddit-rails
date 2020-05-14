class AddProviderToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :provider, :string, limit: 500, default: "", null: false
  end
end
