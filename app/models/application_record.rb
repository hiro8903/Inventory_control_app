class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def the_same_data_cannot_be_created
    
  end
  
end
