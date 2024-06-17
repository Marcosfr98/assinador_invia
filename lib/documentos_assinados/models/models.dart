class MeusDocumentosAssinados {
  String? _iddocumento;
  String? _desnome;
  String? _desdescricao;
  String? _desmotivo;
  String? _boolicp;
  String? _descaminho;
  String? _dtassinatura;

  MeusDocumentosAssinados(
      {String? iddocumento,
      String? desnome,
      String? desdescricao,
      String? desmotivo,
      String? boolicp,
      String? descaminho,
      String? dtassinatura}) {
    if (iddocumento != null) {
      this._iddocumento = iddocumento;
    }
    if (desnome != null) {
      this._desnome = desnome;
    }
    if (desdescricao != null) {
      this._desdescricao = desdescricao;
    }
    if (desmotivo != null) {
      this._desmotivo = desmotivo;
    }
    if (boolicp != null) {
      this._boolicp = boolicp;
    }
    if (descaminho != null) {
      this._descaminho = descaminho;
    }
    if (dtassinatura != null) {
      this._dtassinatura = dtassinatura;
    }
  }

  String? get iddocumento => _iddocumento;

  set iddocumento(String? iddocumento) => _iddocumento = iddocumento;

  String? get desnome => _desnome;

  set desnome(String? desnome) => _desnome = desnome;

  String? get desdescricao => _desdescricao;

  set desdescricao(String? desdescricao) => _desdescricao = desdescricao;

  String? get desmotivo => _desmotivo;

  set desmotivo(String? desmotivo) => _desmotivo = desmotivo;

  String? get boolicp => _boolicp;

  set boolicp(String? boolicp) => _boolicp = boolicp;

  String? get descaminho => _descaminho;

  set descaminho(String? descaminho) => _descaminho = descaminho;

  String? get dtassinatura => _dtassinatura;

  set dtassinatura(String? dtassinatura) => _dtassinatura = dtassinatura;

  MeusDocumentosAssinados.fromJson(Map<String, dynamic> json) {
    _iddocumento = json['iddocumento'];
    _desnome = json['desnome'];
    _desdescricao = json['desdescricao'];
    _desmotivo = json['desmotivo'];
    _boolicp = json['boolicp'];
    _descaminho = json['descaminho'];
    _dtassinatura = json['dtassinatura'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iddocumento'] = this._iddocumento;
    data['desnome'] = this._desnome;
    data['desdescricao'] = this._desdescricao;
    data['desmotivo'] = this._desmotivo;
    data['boolicp'] = this._boolicp;
    data['descaminho'] = this._descaminho;
    data['dtassinatura'] = this._dtassinatura;
    return data;
  }
}
