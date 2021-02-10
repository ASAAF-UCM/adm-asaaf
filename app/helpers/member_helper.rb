# frozen_string_literal: true

module MemberHelper
  # Used to obtain the full name of a member
  #
  # @param member [Member] The member we want the full name of
  # @return [String] The full name
  def full_name(member)
    member.name + ' ' + member.surname1 + ' ' + member.surname2
  end

  # This methods returns the member number if it has one. If the member is so
  # new that he or she has no number yet, returns a translated string which says
  # that no number has been yet provided.
  #
  # @param member [Member] The member we want the member number
  # @return [String] The member number
  def member_number(member)
    member.member_number || t_scoped(:no_member_number)
  end

  # The moodle name of the user, if he or she has one
  #
  # @param member [Member] The member we want the moodle name
  # @return [String] The member moodle name
  def moodle_name(member)
    return t_scoped(:no_moodle_name) if member.moodle_name.blank?

    member.moodle_name
  end

  # Returns if the document_id of the member has expired
  #
  # @param member [Member]
  # @return [boolean]
  def id_expired?(member)
    Time.zone.today > member.id_document_expiration_date
  end
end
