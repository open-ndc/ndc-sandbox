module API

  module Messages

    class Base

      def initialize(doc)
        @timestamp = Time.now.utc.iso8601
        @token = Digest::SHA1.hexdigest @timestamp
        @version = '1.1.5'
        @transaction_identifier = 'TR-00000'
        binding.pry
        @namespaces = {
          'xmlns' => "http://www.iata.org/IATA/EDIST",
          'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
          'EchoToken' => @token,
          'TimeStamp' => @timestamp,
          'Version' => @version,
          'TransactionIdentifier' => @transaction_identifier
        }
      end

    end

  end

end
