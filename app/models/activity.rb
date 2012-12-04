class Activity < ActiveRecord::Base
  attr_accessible :user_id, :target_id, :target_type, :tag, :data

  belongs_to :user
  belongs_to :target, polymorphic: true

  serialize :data

  def target
    target_type.constantize.unscoped{ super }
  end
end
