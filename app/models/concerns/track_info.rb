module TrackInfo
  extend ActiveSupport::Concern

  included do
    serialize :track_info
    after_initialize :init_track_info
  end

  module ClassMethods
  end

  def add_track_info(content, operator_name = nil, note = nil)
    self.track_info ||= []

    info = {time: Time.now, content: content}
    info[:operator_name] = operator_name if operator_name
    info[:note] = note if note

    self.track_info << info
  end

  private

  def init_track_info
    self.track_info ||= []
  end
end
