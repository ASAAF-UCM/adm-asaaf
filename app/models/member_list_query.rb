class MemberListQuery
  def self.search (str)
    Member
      .where('lower(name) LIKE :search OR '\
              'lower(surname1) LIKE :search OR '\
              'lower(surname2) LIKE :search OR '\
              'member_number::varchar LIKE :search OR '\
              'lower(id_document_number) LIKE :search OR '\
              'lower(email) LIKE :search',
              search: "%#{str.downcase}%"
            )
      .order(member_number: :asc)
  end

  def self.page (page, opts={}) 
    opts = {} if opts.nil?
    members_per_page = opts.dig(:members_per_page)|| 25
    type = opts.dig(:type) || 'members'
    
    if type == 'members'
      Member
        .where.not(member_number: [nil, 0])
        .order(member_number: :asc)
        .limit(members_per_page)
        .offset(page * members_per_page)
    else
      Member
        .where(member_number: [nil])
        .order(member_number: :asc)
        .limit(members_per_page)
        .offset(page * members_per_page)
    end
  end
end
