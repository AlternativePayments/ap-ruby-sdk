module ApRubySdk
  module ApiOperations
    module Retrieve

      module ClassMethods
        # TODO implement retrieve with refresh operations if needed. Sometimes is needed if we want to refresh state of object already loaded
        def retrieve

        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end