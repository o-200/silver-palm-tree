require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:subscription) { FactoryBot.create(:subscription) }

  describe 'create subscription' do
    it 'successfully creates a record in the database' do
      expect { subscription }.to change { Subscription.count }.by(1)
    end
  end
end
