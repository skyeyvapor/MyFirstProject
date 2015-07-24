class CreateEvents < ActiveRecord::Migration #檔名是日期_create_??，可用$rails generate model Events產生，後可接參數
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.text :description

      t.timestamps null: false
    end
  end
end
#$rails generate產生完，需要跑$rake db:migrate確定建立表格，可用$rake db:migrate:status知道目前migrate的狀態