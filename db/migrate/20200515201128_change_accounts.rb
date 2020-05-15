class ChangeAccounts < ActiveRecord::Migration[6.0]
  
  def up
    change_table :accounts do |t|
      t.change :first_name, :string, default: ""
      t.change :last_name, :string, default: ""
      t.change :username, :string, default: ""
    end
  end
 
  def down
    change_table :accounts do |t|
      t.change :first_name, :string
      t.change :last_name, :string
      t.change :username, :string
    end
  end

end
