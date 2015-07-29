class AddTicketIdToTrainer < ActiveRecord::Migration
  def change
    add_column :trainers, :number, :string
  end
end
