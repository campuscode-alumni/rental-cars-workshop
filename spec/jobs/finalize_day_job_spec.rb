require 'rails_helper'

describe FinalizeDayJob do
  describe '.auto_enqueue' do
    it 'should schedule return car jobs' do
      rental = create_list(:rental, 10, status: :active, 
                                        finished_at: Time.zone.now)
      yesterday_rental = create(:rental, status: :active, 
                                         finished_at: 1.day.ago)
      tomorrow_rental = create(:rental, status: :active, 
                                        finished_at: 1.day.from_now)

      expect(ReturnCarJob).to receive(:auto_enqueue)
        .exactly(10)
        .times.and_call_original

      FinalizeDayJob.auto_enqueue

      expect(Delayed::Worker.new.work_off).to eq [11, 0]
    end
  end
end