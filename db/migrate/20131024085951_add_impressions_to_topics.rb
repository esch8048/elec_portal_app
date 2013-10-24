class AddImpressionsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :impressions_count, :integer
  end
end
