class EchoDate < ApplicationRecord
  belongs_to :echo

  validates :date, presence: true, uniqueness: { scope: :echo_id }

  scope :ordered, -> { order(date: :asc) }

  def previous_date
    echo.echo_dates.ordered.where("date < ?", date).last
  end
end
