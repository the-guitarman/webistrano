class StageConfiguration < ConfigurationParameter
  include LogicallyDeletable

  belongs_to :stage
  
  validates :stage,
    :presence => true
  validates :name,
    :uniqueness => { :scope => :stage_id }
end
