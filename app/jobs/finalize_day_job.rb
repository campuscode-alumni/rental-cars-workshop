class FinalizeDayJob
  def perform
    Rental.where(
      finished_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day
    ).each do |rental|
      ReturnCarJob.auto_enqueue(rental.id)
    end
  end

  def self.auto_enqueue
    Delayed::Job.enqueue(FinalizeDayJob.new)
  end
end