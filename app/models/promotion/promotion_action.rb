class Promotion::PromotionAction < ActiveRecord::Base
  # table name
  self.table_name = 'promotion_actions'
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs :promotion
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
