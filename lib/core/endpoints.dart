class Endpoints {
  static String viaCepUrl = 'https://viacep.com.br/ws/#CEP#/json/';
  static String mapsApi =
      'https://maps.googleapis.com/maps/api/geocode/json?address=#ADDRESS#&key=#KEY#';
  static String mapUrlTemplate =
      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
}
