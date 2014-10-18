module Pusher
  module TicketCallbacks
    extend ActiveSupport::Concern

    include Pusher::PusherNames
    included do
      after_save :trigger_pusher
      include TriggerPusherDecorator
    end

    def trigger_pusher
      Pusher.trigger([
        C_TICKET % { uid: uid },
        C_TICKETS
      ], E_TICKET_UPDATE, as_json)
    end
  end
end
