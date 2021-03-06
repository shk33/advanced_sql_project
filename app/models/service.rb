class Service < ActiveRecord::Base
  #Relationships
  belongs_to :service_arrangement
  belongs_to :service_request
  has_and_belongs_to_many :tags
  
  #Model Validations
  validates :title,       presence: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }
  validate  :not_negative_cost

  private
    def not_negative_cost
      if cost.to_i < 0
        self.errors.add(:negative_cost,"can't be lower than zero points")
      end
    end

end
