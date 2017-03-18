module Providers
  class Facebook < Base
    def client(data)
      @client ||= Koala::Facebook::API.new(data['token'])
    end
  end
end
