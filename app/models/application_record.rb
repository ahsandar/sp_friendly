class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.response_obj(status, response)
    {
      success: status,
      response: response
    }
  end

end
