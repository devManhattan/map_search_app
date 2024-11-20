class DatabaseScripts {
  //int versão com array de scripts
  static Map<int, List<String>> update = {
    1: [
      """CREATE TABLE IF NOT EXISTS history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        locationid INTEGER,
        logradouro TEXT ,
        complemento TEXT ,
        cep TEXT ,
        numero TEXT
      );"""
    ]
  };

  //Array com todos os create table da criação do banco
  static List<String> create = [
    """CREATE TABLE IF NOT EXISTS location (
        id INTEGER PRIMARY KEY AUTOINCREMENT, -- ID auto-incrementado
        cep TEXT ,
        logradouro TEXT ,
        complemento TEXT,
        numero TEXT,
        unidade TEXT,
        bairro TEXT ,
        localidade TEXT ,
        uf TEXT ,
        estado TEXT ,
        regiao TEXT,
        ibge TEXT ,
        gia TEXT,
        ddd TEXT ,
        siafi TEXT 
      );""",
  ];
}
