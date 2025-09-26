class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend # can be adapted to only update for specific streams for privacy reasons
end
