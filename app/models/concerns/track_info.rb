module TrackInfo
  extend ActiveSupport::Concern

  included do
    serialize :track_info
    after_initialize :init_track_info
  end

  module ClassMethods
  end

  def get_track_time(event)
    info = track_info.select { |info| info[:event] == event.to_s }[0]
    info[:time] if info
  end

  def add_track_info(event, operator_id = nil, note = nil)
    init_track_info
    info = { time: Time.now, event: event }
    info[:operator_id] = operator_id if operator_id
    info[:note] = note if note
    track_info << info
  end

  def update_state_with_track!(event, operator, note = nil)
    try(event)
    add_track_info(event, operator.id, note)
    update_totals
    save
  end

  private

  def init_track_info
    self.track_info ||= []
  end
end
