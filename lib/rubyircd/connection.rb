class RubyIRCd
  class Connection
    attr_accessor :server

    def post_init
    end

    def unbind
      server.connections.delete(self)
    end
  end
end
