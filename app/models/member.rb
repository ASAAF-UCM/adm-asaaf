# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :role_allocations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable

  validates :name, :surname1, presence: true, length: { in: 2..256 }
  validates :surname2, length: { maximum: 256 }
  validates :birthdate, :id_document_type_id, :id_document_number,
            :id_document_expiration_date, presence: true
  validates :id_document_expiration_date, later_than_today: true
  validates :birthdate, earlier_than: { time_interval: 14.years + 1.day }
  validates :member_since,
            :last_active_member_confirmation,
            earlier_than_tomorrow: true

  include ImageUploader::Attachment(:image)
end
