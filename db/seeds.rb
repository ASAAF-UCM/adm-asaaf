# frozen_string_literal: true

%w[DNI NIE Passport].each do |id_type|
  IdDocumentType.find_or_create_by name: id_type
end

%w[Fundador Honorario Numerario].each do |member_type|
  MemberType.find_or_create_by name: member_type
end
