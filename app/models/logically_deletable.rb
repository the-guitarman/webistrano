module LogicallyDeletable
  class << self
    def included(klass)
      klass.class_eval do
        default_scope where("#{table_name}.deleted_at IS NULL")
      end
    end
  end

  class NotLogicallyDeletable < RuntimeError; end

  def deleted?
    !!deleted_at
  end

  def delete_logically
    raise NotLogicallyDeletable.new("`deleted_at' column is required to be logically deleted") unless respond_to?(:deleted_at)
    update_column(:deleted_at, Time.now)
  end
end
