# frozen_string_literal: true

# This class is a model arond a devise user. Instead of calling the user of the
# web user, we have selected instead the name member, in order to reflect that
# all the people who will use this app are (or will be) members of ASAAF.
class Member < ApplicationRecord
  has_many :role_allocations, dependent: :destroy
  has_one :member_setting, dependent: :destroy

  has_one_attached :id_image

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
  validates :id_image,
            attached: true,
            content_type: %i[png jpg jpeg],
            size: { less_than: 250.kilobytes }

  after_create :create_settings_for_user

  # Updates the password of the member.
  # @param update_params [Hash] (See ProfileController#update_params)
  #
  # @return [Member, false] if save fails
  def update_password(update_params)
    return false if update_params[:password] != update_params[:password_confirmation]

    self.password = update_params[:password]
    save(skip_for_profile: true)
  end

  # Drop_out a member of the association (dar de baja). This method anonymizes
  # an entry in the database in order to make clear that a member is not anymore
  # a member of the association.
  #
  # Can't be used on the same user that requests the drop out, nor on a user
  # with a role.
  #
  # @param params [hash]
  # @option params [Member] :requested_by The user who requested the drop_out
  #
  # @return [Member, false] Member if OK, false if drop_out fails
  def drop_out(params = nil)
    # We don't want to remove the actual user
    return false if !params.nil? && (params[:requested_by] == self)

    # We don't want to remove a member with a role
    return false unless roles.length.zero?

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

  # The roles which the member has assigned and active
  # @return [Array] with the name of the different roles
  def roles
    RoleAllocation
      .joins(:member, :role_type)
      .where(member_id: id, is_active: true)
      .pluck(:role_name)
  end

  # Convert a person in a member of the association by assigning the correct
  # member_type_id and a member_number.
  #
  # @return [Member, false] Member if all OK, false if fails
  def convert_into_member
    return false unless member_number.nil?
    return false unless member_type_id.nil?

    self.member_type_id = 3
    self.member_number = Member.maximum(:member_number) + 1
    self.member_since = Date.today
    self.last_active_member_confirmation = Date.today

    save
  end

  # Make devise sending emails in the language that the user has chosen
  def send_devise_notification(notification, *args)
    I18n.with_locale(member_setting.locale || I18n.default_locale) do
      super(notification, *args)
    end
  end

  private

  # Creates the settings for the created user
  # @return Member
  def create_settings_for_user
    MemberSetting.create(member_id: id, locale: I18n.locale.to_s)
  end
end
