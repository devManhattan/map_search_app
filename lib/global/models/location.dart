class Location {
  final int? id;
  final String cep;
  final String logradouro;
  final String? numero;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String estado;

  Location({
    required this.id,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.estado,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      estado: json['estado'],
    );
  }

  factory Location.fromDb(Map<String, dynamic> db) {
    return Location(
      id: db['id'],
      cep: db['cep'],
      logradouro: db['logradouro'],
      numero: db['numero'],
      complemento: db['complemento'],
      bairro: db['bairro'],
      localidade: db['localidade'],
      uf: db['uf'],
      estado: db['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'estado': estado,
    };
  }
}
