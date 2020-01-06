require 'webmock/rspec'

RSpec.describe ZipCode::Strategy do
  zip_code = '97305'

  let(:sepomex_zip_code_response) do
    [
      {
        error: false,
        code_error: 0,
        error_message: 'null',
        response: {
          cp: zip_code,
          asentamiento: 'Granjas Cholul',
          tipo_asentamiento: 'Colonia',
          municipio: 'Mérida',
          estado: 'Yucatán',
          ciudad: '',
          pais: 'México',
        },
      },
      {
        error: false,
        code_error: 0,
        error_message: 'null',
        response: {
          cp: zip_code,
          asentamiento: 'Cabo Norte',
          tipo_asentamiento: 'Fraccionamiento',
          municipio: 'Mérida',
          estado: 'Yucatán',
          ciudad: '',
          pais: 'México',
        },
      },
    ]
  end

  let(:sepomex_invalid_zip_code_response) do
    {
      error: true,
      code_error: 102,
      error_message: 'La longitud del cp es inválida',
      response: 'null',
    }
  end

  let(:sepomex_acrogenesis_valid_zip_code_response) do
    {
      codigo_postal: '97305',
      municipio: 'Mérida',
      estado: 'Yucatán',
      colonias: ['Cholul'],
    }
  end

  let(:sepomex_acrogenesis_invalid_zip_code_response) do
    {
      codigo_postal: '94',
      municipio: '',
      estado: '',
      colonias: [],
    }
  end

  describe 'it works' do
    context 'when hckdrk works' do
      before do
        stub_request(:get, "https://api-sepomex.hckdrk.mx/query/info_cp/#{zip_code}").to_return(
          body: JSON.dump(sepomex_zip_code_response), status: 200
        )
      end

      subject { described_class.call(zip_code) }

      it do
        expect { subject }.not_to raise_error
        expect(subject.state).to eq 'Yucatán'
      end
    end

    context 'when hckdrk fails but acrogenesis works' do
      before do
        stub_request(:get, "https://api-sepomex.hckdrk.mx/query/info_cp/#{zip_code}").to_return(
          body: JSON.dump(sepomex_invalid_zip_code_response), status: 200
        )

        stub_request(:get, "https://api-codigos-postales.herokuapp.com/v2/codigo_postal/#{zip_code}").to_return(
          body: JSON.dump(sepomex_acrogenesis_valid_zip_code_response), status: 200
        )
      end

      subject { described_class.call(zip_code) }

      it do
        expect { subject }.not_to raise_error
        expect(subject.state).to eq 'Yucatán'
      end
    end
  end

  describe 'fails correctly' do
    context 'when both APIs fail' do
      before do
        stub_request(:get, "https://api-sepomex.hckdrk.mx/query/info_cp/#{zip_code}").to_return(
          body: JSON.dump(sepomex_invalid_zip_code_response), status: 200
        )

        stub_request(:get, "https://api-codigos-postales.herokuapp.com/v2/codigo_postal/#{zip_code}").to_return(
          body: JSON.dump(sepomex_acrogenesis_invalid_zip_code_response), status: 200
        )
      end

      it do
        expect do
          described_class.call(zip_code)
        end.to raise_error ZipCode::DataNotFoundError
      end
    end

    context 'when no zip_code sent' do
      it do
        expect do
          described_class.call
        end.to raise_error ArgumentError
      end
    end
  end
end
