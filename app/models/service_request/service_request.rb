class ServiceRequest < ActiveRecord::Base
  #Relationships
  belongs_to :user
  has_one    :service, dependent: :destroy
  has_many   :offers
  has_many   :tags, through: :service

  #Nested Attributes
  accepts_nested_attributes_for :service

  #Model Validations
  validates :service, presence: true
  validates :user,    presence: true

  #Scope
  default_scope { order("created_at DESC") } 

  def self.search_by_title search
    if search
      ServiceRequest.joins(:service).where("LOWER(title) like ? ", "%#{search}%".downcase).group('service_requests.id')
    else
      ServiceRequest.all
    end
  end

  def self.search_by_tag tags
    if tags
      # ServiceRequest.joins(:tags).where(tags: {id: tag_id.to_i})
      tags.map! { |tag_id| tag_id.to_i }
      ServiceRequest.joins(:tags).where(tags: {id: tags}).group('service_requests.id')
    else
      ServiceRequest.all
    end
  end

  def self.get_suggested_services(user)   
    ServiceRequest.take(3)
  end

  def self.ordered_by_friend_priority_with_tag(user_id, tag_id)
    joins(
      user: [:passive_relationships]
    ).where(
      'follower_id = ?',
      user_id
    ).joins(:tags).where(
      tags: {
        id: tag_id
      }
    )    
  end

  def accepted_offer
    offers.where(accepted: true).first
  end

  def has_accepted_offer?
    !offers.where(accepted: true).first.nil?
  end

  def has_offer_from_user? user
    !offers.where(user: user).first.nil?
  end
  
end
