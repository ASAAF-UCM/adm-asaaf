# frozen_string_literal: true

# Class for managing the different types of document ids ASAAF accepts for
# registering new members.
#
# Actual numbers came from `db/seeds.rb`, which are:
#  1 - DNI
#  2 - NIE
#  3 - Passport
class IdDocumentType < ApplicationRecord
end
