class RubyIRCd
  class Server
    attr_accessor :connections

    def initialize
      @connections = []
    end

    def start
      @signature = EventMachine.start_server(RubyIRCd.config[:host], RubyIRCd.config[:port], RubyIRCd::Connection) do |con|
        con.server = self
      end
    end

    def stop
      EventMachine.stop_server(@signature)

      unless wait_for_connections_and_stop
        # Still some connections running, schedule a check later
        EventMacine.add_periodic_timer(1) { wait_for_connections_and_stop }
      end
    end

    def wait_for_connections_and_stop
      if @connections.empty?
        EventMachine.stop
        true
      else
        false
      end
    end
  end
end
