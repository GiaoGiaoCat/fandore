module TrackInfo
  extend ActiveSupport::Concern

  included do
    serialize :track_info
    after_initialize :init_track_info
  end

  module ClassMethods
  end

  def add_track_info(event, operator_id = nil, note = nil)
    init_track_info
    info = { time: Time.now, event: event }
    info[:operator_id] = operator_id if operator_id
    info[:note] = note if note
    self.track_info << info
  end


  def update_state(event, operator)
    self.try(event)
    self.add_track_info(event, operator.id)
  end

  private

  def init_track_info
    self.track_info ||= []
  end
end
