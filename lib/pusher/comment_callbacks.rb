module Pusher
  module CommentCallbacks
    extend ActiveSupport::Concern

    include Pusher::PusherNames
    included do
      after_create :trigger_pusher
      include TriggerPusherDecorator
    end

    def trigger_pusher
      Pusher.trigger([
        C_TICKET % { uid: target.try(:uid) }
      ], E_TICKET_REPLY, as_json) if target.is_a?(Ticket)
    end
  end
end
