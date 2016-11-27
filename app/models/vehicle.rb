class Vehicle < ApplicationRecord
  has_many :images

  monetize :asking_price_cents, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }

  validates_presence_of :vin, :year, :make, :model
  validates_numericality_of :year, greater_than_or_equal_to: 1900, less_than: 2050
  validates_length_of :vin, is: 17
  validates_numericality_of :mileage, greater_than_or_equal_to: 0, less_than: 1_000_000, allow_nil: true

  scope :active, -> { where(active: true) }

  def primary_image
    images.find_by(primary: true)
  end

  def has_primary_image?
    primary_image.present?
  end

  def non_primary_images
    images.where(primary: false)
  end
end

# == Schema Information
#
# Table name: vehicles
#
#  id                 :integer          not null, primary key
#  vin                :string           not null
#  year               :integer          not null
#  make               :string           not null
#  model              :string           not null
#  trim               :string
#  mileage            :integer
#  exterior_color     :string
#  interior_color     :string
#  transmission       :string
#  body_style         :string
#  drivetrain         :string
#  engine             :string
#  options            :text
#  comments           :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  asking_price_cents :integer
#  active             :boolean          default("true")
#
