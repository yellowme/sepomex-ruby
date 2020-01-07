module SEPOMEX
  module Clients
    class Acrogenesis
      def initialize(zip_code)
        @zip_code = zip_code
      end

      #
      # Método que se encarga de solicitar información de un código postal
      #
      # @raise [SepomexError]
      #
      def query
        SEPOMEX_Acrogenesis::General.info_zip_code(zip_code: @zip_code)
      end
    end
  end
end
