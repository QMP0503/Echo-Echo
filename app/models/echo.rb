class Echo < ApplicationRecord
  belongs_to :classroom
  has_many :echo_dates, dependent: :destroy

  validates :name, presence: true
  validates :private, inclusion: { in: [ true, false ] }

  scope :ordered, -> { order(id: :desc) }
  scope :public_echos, -> { where(private: false) }
  scope :private_echos, -> { where(private: true) }

  # Broadcast to classroom-specific streams
  broadcasts_to ->(echo) { [ echo.classroom, "echos" ] }, inserts_by: :prepend

  # Calculate total number of echo dates for this echo
  def total_dates
    echo_dates.count
  end
end
