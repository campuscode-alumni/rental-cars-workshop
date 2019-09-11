require 'rails_helper'

describe NilUser do
  describe 'admin?' do
    it 'should be false' do
      expect(NilUser.new.admin?).to eq false
    end
  end
end
