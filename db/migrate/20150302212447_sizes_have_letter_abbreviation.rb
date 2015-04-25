class SizesHaveLetterAbbreviation < ActiveRecord::Migration
  def up
    add_column :sizes, :letter_code, :string
  end

  def down
    remove_column :sizes, :letter_code
  end
end
