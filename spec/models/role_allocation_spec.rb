# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleAllocation, type: :model do
  describe 'when saved' do
    let(:member) { FactoryBot.create(:random_member) }

    it 'is invalid if no member_id is provided' do
      ra = described_class.new
      ra.role_type_id = 2
      expect(ra.save).to eq(false)
    end

    it 'is invalid if member_id does not exist' do
      ra = described_class.new
      ra.role_type_id = 2
      ra.id = Faker::Internet.uuid
      expect(ra.save).to eq(false)
    end

    it 'is invalid if role_type_id is not provided' do
      ra = described_class.new
      ra.member_id = member.id
      expect(ra.save).to eq(false)
    end

    it 'is valid with valid attributes' do
      ra = described_class.new
      ra.member_id = member.id
      ra.role_type_id = 2
      expect(ra.save).to eq(true)
    end
  end

  describe 'when promoting' do
    let(:member) { FactoryBot.create(:random_member) }
    let(:ra)     { described_class.new }
    let(:params) { { member_id: member.id } }

    it 'promotes to admin' do
      expect { ra.promote_to_admin!(member) }
        .to change {
              described_class.select(:role_type_id)
                             .where(role_type_id: 1).count
            }.by(1)
    end

    it 'promotes to accounting' do
      params[:role_type_id] = 2
      expect { ra.promote_to(params) }
        .to change {
              described_class.select(:role_type_id)
                             .where(role_type_id: 2)
                             .count
            }.by(1)
    end

    it 'promotes to secretary' do
      params[:role_type_id] = 3
      expect { ra.promote_to(params) }
        .to change {
              described_class.select(:role_type_id)
                             .where(role_type_id: 3)
                             .count
            }.by(1)
    end

    it 'promotes to loans' do
      params[:role_type_id] = 4
      expect { ra.promote_to(params) }
        .to change {
              described_class.select(:role_type_id)
                             .where(role_type_id: 4)
                             .count
            }.by(1)
    end
  end
end
