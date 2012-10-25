class User < ActiveRecord::Base
  include LogicallyDeletable

  # Virtual attribute for the unencrypted password
  #attr_accessor :password

  has_many :stages_user
  has_many :stages, :through => :stages_user
  has_many :deployments, :dependent => :nullify, :order => 'created_at DESC'
  has_many :activities, :as => :target, :dependent => :destroy
  has_and_belongs_to_many :projects

  attr_accessible :login, :email, :password, :password_confirmation, :time_zone, :tz

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false 

	def read_only(stage)
    su = stages_user.find_by_stage_id(stage.id)
		return su.read_only? if su
		return false
  end

	def access(stage)
		(stages_user.find_by_stage_id(stage.id).read_only?)? 'read only' : 'full access'
	end

	def project_stages(project)
		return stages if !stages
    stages.select{|stage| stage.project.id == project.id}
	end

  def validate_on_update
    if User.find(self.id).admin? && !self.admin?
      errors.add('admin', 'status can no be revoked as there needs to be one admin left.') if User.admin_count == 1
    end
  end


  # Include default devise modules. Others available are:
  # :token_authenticatable, :registerable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
    :recoverable, :rememberable, :trackable, :validatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :time_zone, :tz, :admin


  scope :enabled,    where(:disabled_at => nil)
  scope :disabled,   where("disabled_at IS NOT NULL")
  scope :non_admins, where(:admin => false, :disabled_at => nil)
  scope :admins,     where(:admin => true, :disabled_at => nil)

  validate :guard_last_admin, :on => :update

  def name
    login
  end

  def revoke_admin!
    self.admin = false
    self.save!
  end

  def make_admin!
    self.admin = true
    self.save!
  end

  def self.admin?
    self.admin
  end

  def disabled?
    self.disabled_at.present?
  end

  def disable!
    self.update_column(:disabled_at, Time.now)
    self.forget_me!
  end

  def enable!
    self.update_column(:disabled_at, nil)
  end

  protected

  def guard_last_admin
    if User.find(self.id).admin? && !self.admin?
      errors.add('admin', 'status can no be revoked as there needs to be one admin left.') if User.admins.count == 1
    end
  end

end
