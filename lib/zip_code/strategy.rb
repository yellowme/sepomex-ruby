module ZipCode
  class Strategy
    ACROGENESIS = 'acrogenesis'.freeze
    HCKDRK = 'hckdrk'.freeze

    def self.call(*args, &block)
      new(*args, &block).call
    end

    def initialize(zip_code)
      @zip_code = zip_code
      @clients = [HCKDRK, ACROGENESIS]
    end

    def call
      raise ArgumentError if @zip_code.blank?

      zip_code_result = {}
      @clients.each do |client|
        strategy = processor(client)
        zip_code_result = strategy.query
        break if zip_code_result.settlement.present?
      rescue StandardError => e
      end
      raise DataNotFoundError if zip_code_result.blank? || zip_code_result.settlement.blank?

      zip_code_result
    end

    private

    def processor(client)
      case client
      when HCKDRK
        ZipCode::Clients::Hckdrk.new(@zip_code)
      when ACROGENESIS
        ZipCode::Clients::Acrogenesis.new(@zip_code)
      else
        raise ArgumentError
      end
    end
  end
end
