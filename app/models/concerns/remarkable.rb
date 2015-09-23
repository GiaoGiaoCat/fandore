module Remarkable
  extend ActiveSupport::Concern

  included do
    serialize :remark, Hash
  end

  module ClassMethods
  end

  def find_remark_by_line_item(line_item)
    remark[line_item.id]
  end

  def update_remark_by_line_item(line_item)
    if line_items.include? line_item
      self.remark[line_item.id] = line_item.remark
    else
      remark.delete(id)
    end
    save
  end

end
