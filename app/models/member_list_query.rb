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
end
