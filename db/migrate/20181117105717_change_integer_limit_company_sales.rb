class ChangeIntegerLimitCompanySales < ActiveRecord::Migration[5.2]
  def change
    def change
      change_column :company_sales, :amount_of_sales, :integer, limit: 8
      change_column :company_sales, :ordinary_income, :integer, limit: 8
      change_column :company_sales, :profit, :integer, limit: 8
      change_column :company_sales, :asset, :integer, limit: 8
    end
  end
end
