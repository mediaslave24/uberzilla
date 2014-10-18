module Pusher
  module TriggerPusherDecorator
    extend ActiveSupport::Concern

    included do
      alias_method_chain :trigger_pusher, :decoration
    end

    def trigger_pusher_with_decoration
      if !Rails.env.test?
        trigger_pusher_without_decoration
      end
    end
  end
end
