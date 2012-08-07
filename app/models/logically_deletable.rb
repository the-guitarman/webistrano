module LogicallyDeletable
  class << self
    def included(klass)
      klass.class_eval do
        include InstanceMethods
        default_scope where("#{table_name}.deleted_at IS NULL")
      end

      klass.extend ClassMethods
    end
  end

  class NotLogicallyDeletable < RuntimeError; end

  module ClassMethods
    def count_logically(column_name = nil, options = {})
      scope = "#{table_name}.deleted_at IS NULL"

      if options[:conditions]
        options[:conditions] << " AND #{scope}"
      else
        options[:conditions] = scope
      end

      count(column_name, options)
    end
  end

  module InstanceMethods
    def deleted?
      !!deleted_at
    end

    def delete_logically
      raise NotLogicallyDeletable.new("`deleted_at' column is required to be logically deleted") unless respond_to?(:deleted_at)
      update_column(:deleted_at, Time.now)
    end

    def delete_logically_with_asscociation
      delete_logically
    end
  end
end
