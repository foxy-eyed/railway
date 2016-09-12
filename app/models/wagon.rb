class Wagon < ApplicationRecord
  CATEGORIES = { economy: 'Economy class', coupe: 'Coupe' }.freeze

  belongs_to :train

  validates :train_id, presence: true
  validates :category, inclusion: { in: %w(economy coupe) }
  validates :top_places, :bottom_places, numericality: { only_integer: true, greater_than: 0 }

  def self.categories
    CATEGORIES.invert
  end

  def category_label
    CATEGORIES.fetch(category.to_sym)
  end
end
