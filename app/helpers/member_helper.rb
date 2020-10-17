# frozen_string_literal: true

module MemberHelper
  def full_name(member)
    member.name + ' ' + member.surname1 + ' ' + member.surname2
  end

  def member_number(member)
    member.member_number || t_scoped(:no_member_number)
  end

  def moodle_name(member)
    return t_scoped(:no_moodle_name) if member.moodle_name.blank?

    member.moodle_name
  end

  def id_number_and_expiry_date(member)
    member.id_document_number + ' ('\
    + t_scoped(:expiry) + ': '\
    + member.id_document_expiration_date.to_s\
    + ')'
  end
end
