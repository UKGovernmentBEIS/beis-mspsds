class CorrectiveAction < ApplicationRecord
  include DateConcern

  belongs_to :investigation
  belongs_to :business
  belongs_to :product

  has_many_attached :documents

  def get_date_key
    :date_decided
  end

  validate :date_decided_cannot_be_in_the_future

  validates :summary, presence: true
  validates :date_decided, presence: true
  validates :investigation, presence: true
  validates :business, presence: true
  validates :product, presence: true

  def date_decided_cannot_be_in_the_future
    errors.add(:date_decided, "can't be in the future") if
        date_decided.present? and date_decided > Date.today
  end
end
