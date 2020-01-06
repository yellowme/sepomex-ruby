module STPTestHelpers
  def self.MOCK_ERROR(error_code)
    {
      'descripcionError' => 'regular error msg',
      'id' => error_code,
    }
  end

  def self.MOCK_SUCCESS
    {
      'id' => 5_840_086,
      'empresa' => 'FINVE',
      'folioOrigen' => '5840086',
      'estado' => 'Exito',
      'causaDevolucion' => '',
    }
  end
end
