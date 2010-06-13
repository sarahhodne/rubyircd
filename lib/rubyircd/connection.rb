class RubyIRCd
  class Connection
    attr_accessor :server

    def post_init
      @ping_timer = EventMa
    end

    def unbind
      server.connections.delete(self)
    end
  end
end
