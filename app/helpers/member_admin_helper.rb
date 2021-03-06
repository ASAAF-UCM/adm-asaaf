# frozen_string_literal: true

module MemberAdminHelper
  def sign_in_time(member)
    curr = member.current_sign_in_at
    if curr.nil?
      t_scoped :did_not_sign_in
    else
      curr
    end
  end

  def sign_in_ip(member)
    curr = member.current_sign_in_ip
    if curr.nil?
      t_scoped :did_not_sign_in
    else
      curr
    end
  end

  def email_confirmed_at(member)
    curr = member.confirmed_at
    if curr.nil? && member.member_number != 0
      (
        link_to t_scoped(:confirm_email),
                confirm_email_path(id: member.id),
                method: :post,
                class: 'btn btn-primary btn-sm'
      )
    else
      curr
    end
  end

  def member_since(member)
    curr = member.member_since
    if curr.nil?
      t_scoped :no_member
    else
      curr
    end
  end

  def member_admin_edit_title(member)
    if member.member_number.nil?
      t_scoped :title_no_member
    else
      "#{t_scoped(:title_member)} #{member.member_number}"
    end
  end
end
