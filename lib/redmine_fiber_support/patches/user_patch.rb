module RedmineFiberSupport
  module Patches
    module UserPatch
      extend ActiveSupport::Concern
      included do
        def self.current=(user)
          Thread.current["fiber#{Fiber.current.__id__}".to_sym][:current_user] = user if Thread.current["fiber#{Fiber.current.__id__}".to_sym].try(:[], :current_user)
        end

        def self.current
          (Thread.current["fiber#{Fiber.current.__id__}".to_sym] ||= {})[:current_user] ||= User.anonymous
        end
      end
    end
  end
end