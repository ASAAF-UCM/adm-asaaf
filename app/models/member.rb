# frozen_string_literal: true

# This class is a model arond a devise user. Instead of calling the user of the
# web user, we have selected instead the name member, in order to reflect that
# all the people who will use this app are members of ASAAF.
class Member < ApplicationRecord
  has_many :role_allocations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable

  attr_accessor :skip_for_profile

  validates :name, :surname1, presence: true, length: { in: 2..256 }
  validates :surname2, length: { maximum: 256 }
  validates :birthdate, :id_document_type_id, :id_document_number,
            :id_document_expiration_date, presence: true
  validates :id_document_expiration_date, later_than_today: true,
                                          unless: :skip_for_profile
  validates :birthdate, earlier_than: { time_interval: 14.years + 1.day }
  validates :member_since,
            :last_active_member_confirmation,
            earlier_than_tomorrow: true

  include ImageUploader::Attachment(:image)

  def update_password(update_params)
    return false if update_params[:password] != update_params[:password_confirmation]

    self.password = update_params[:password]
    save(skip_for_profile: true)
  end

  def drop_out(params = nil)
    # We don't want to remove the actual user
    unless params.nil?
      return false if params[:requested_by] == self
    end
    
    # We don't want to remove a member with a role
    return false unless self.roles.length.zero?

    lock_access!({ send_instructions: false })
    save

    skip_reconfirmation!
    update_attribute :email, "#{id}@example.com"

    update_attribute :name, '--removed--'
    update_attribute :surname1, '--removed--'
    update_attribute :surname2, ''
    update_attribute :birthdate, Date.new(1900, 1, 1)
    update_attribute :id_document_expiration_date, Date.new(1900, 1, 1)
    update_attribute :id_document_number, '13-J'
    update_attribute :member_number, 0
    update_attribute :member_type_id, 4
    update_attribute :member_since, nil
    update_attribute :last_active_member_confirmation, nil
    update_attribute :moodle_name, nil
    update_attribute :reset_password_token, nil
    update_attribute :reset_password_sent_at, nil
    update_attribute :remember_created_at, nil
    update_attribute :current_sign_in_at, nil
    update_attribute :last_sign_in_at, nil
    update_attribute :current_sign_in_ip, nil
    update_attribute :last_sign_in_ip, nil
    update_attribute :confirmation_token, nil
    update_attribute :confirmed_at, nil
    update_attribute :confirmation_sent_at, nil
    update_attribute :unconfirmed_email, nil
    update_attribute :unlock_token, nil
  end

  def roles
    RoleAllocation
      .joins(:member, :role_type)
      .where(member_id: self.id, is_active: true)
      .pluck(:role_name)
  end

  def convert_into_member
    return false unless self.member_number.nil?
    return false unless self.member_type_id.nil?

    self.member_type_id = 3
    self.member_number = Member.maximum(:member_number) + 1
    self.member_since = Date.today
    self.last_active_member_confirmation = Date.today

    save
  end
end
