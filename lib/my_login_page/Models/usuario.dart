class UsuarioModel {
  String? _statusCode;
  String? _senha;
  String? _userID;
  String? _usuario;
  String? _cRO;
  String? _nome;
  String? _telefone;
  String? _desplano;
  String? _desufcro;
  String? _desespecialidade;
  String? _cpf;
  String? _email;
  String? _desphoto;

  UsuarioModel(
      {String? statusCode,
      String? senha,
      String? userID,
      String? usuario,
      String? cRO,
      String? nome,
      String? telefone,
      String? desplano,
      String? desufcro,
      String? desespecialidade,
      String? cpf,
      String? email,
      String? desphoto}) {
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
    if (senha != null) {
      this._senha = senha;
    }
    if (userID != null) {
      this._userID = userID;
    }
    if (usuario != null) {
      this._usuario = usuario;
    }
    if (cRO != null) {
      this._cRO = cRO;
    }
    if (nome != null) {
      this._nome = nome;
    }
    if (telefone != null) {
      this._telefone = telefone;
    }
    if (desplano != null) {
      this._desplano = desplano;
    }
    if (desufcro != null) {
      this._desufcro = desufcro;
    }
    if (desespecialidade != null) {
      this._desespecialidade = desespecialidade;
    }
    if (cpf != null) {
      this._cpf = cpf;
    }
    if (email != null) {
      this._email = email;
    }
    if (desphoto != null) {
      this._desphoto = desphoto;
    }
  }

  String? get statusCode => _statusCode;
  set statusCode(String? statusCode) => _statusCode = statusCode;
  String? get senha => _senha;
  set senha(String? senha) => _senha = senha;
  String? get userID => _userID;
  set userID(String? userID) => _userID = userID;
  String? get usuario => _usuario;
  set usuario(String? usuario) => _usuario = usuario;
  String? get cRO => _cRO;
  set cRO(String? cRO) => _cRO = cRO;
  String? get nome => _nome;
  set nome(String? nome) => _nome = nome;
  String? get telefone => _telefone;
  set telefone(String? telefone) => _telefone = telefone;
  String? get desplano => _desplano;
  set desplano(String? desplano) => _desplano = desplano;
  String? get desufcro => _desufcro;
  set desufcro(String? desufcro) => _desufcro = desufcro;
  String? get desespecialidade => _desespecialidade;
  set desespecialidade(String? desespecialidade) =>
      _desespecialidade = desespecialidade;
  String? get cpf => _cpf;
  set cpf(String? cpf) => _cpf = cpf;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get desphoto => _desphoto;
  set desphoto(String? desphoto) => _desphoto = desphoto;

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['StatusCode'];
    _senha = json['senha'];
    _userID = json['UserID'];
    _usuario = json['Usuario'];
    _cRO = json['CRO'];
    _nome = json['nome'];
    _telefone = json['telefone'];
    _desplano = json['desplano'];
    _desufcro = json['desufcro'];
    _desespecialidade = json['desespecialidade'];
    _cpf = json['cpf'];
    _email = json['email'];
    _desphoto = json['desphoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this._statusCode;
    data['senha'] = this._senha;
    data['UserID'] = this._userID;
    data['Usuario'] = this._usuario;
    data['CRO'] = this._cRO;
    data['nome'] = this._nome;
    data['telefone'] = this._telefone;
    data['desplano'] = this._desplano;
    data['desufcro'] = this._desufcro;
    data['desespecialidade'] = this._desespecialidade;
    data['cpf'] = this._cpf;
    data['email'] = this._email;
    data['desphoto'] = this._desphoto;
    return data;
  }
}
