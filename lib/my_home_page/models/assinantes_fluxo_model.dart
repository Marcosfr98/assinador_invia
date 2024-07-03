class AssinanteFluxoModel {
  String? _idassinatura;
  String? _idassinante;
  String? _desnome;
  String? _descpf;
  String? _desemail;
  String? _destelefone;
  String? _dtassinatura;
  String? _destipo;
  String? _despapel;
  String? _desautenticacao;
  String? _assinado;

  AssinanteFluxoModel(
      {String? idassinatura,
      String? idassinante,
      String? desnome,
      String? descpf,
      String? desemail,
      String? destelefone,
      String? dtassinatura,
      String? destipo,
      String? despapel,
      String? desautenticacao,
      String? assinado}) {
    if (idassinatura != null) {
      this._idassinatura = idassinatura;
    }
    if (idassinante != null) {
      this._idassinante = idassinante;
    }
    if (desnome != null) {
      this._desnome = desnome;
    }
    if (descpf != null) {
      this._descpf = descpf;
    }
    if (desemail != null) {
      this._desemail = desemail;
    }
    if (destelefone != null) {
      this._destelefone = destelefone;
    }
    if (dtassinatura != null) {
      this._dtassinatura = dtassinatura;
    }
    if (destipo != null) {
      this._destipo = destipo;
    }
    if (despapel != null) {
      this._despapel = despapel;
    }
    if (desautenticacao != null) {
      this._desautenticacao = desautenticacao;
    }
    if (assinado != null) {
      this._assinado = assinado;
    }
  }

  String? get idassinatura => _idassinatura;
  set idassinatura(String? idassinatura) => _idassinatura = idassinatura;
  String? get idassinante => _idassinante;
  set idassinante(String? idassinante) => _idassinante = idassinante;
  String? get desnome => _desnome;
  set desnome(String? desnome) => _desnome = desnome;
  String? get descpf => _descpf;
  set descpf(String? descpf) => _descpf = descpf;
  String? get desemail => _desemail;
  set desemail(String? desemail) => _desemail = desemail;
  String? get destelefone => _destelefone;
  set destelefone(String? destelefone) => _destelefone = destelefone;
  String? get dtassinatura => _dtassinatura;
  set dtassinatura(String? dtassinatura) => _dtassinatura = dtassinatura;
  String? get destipo => _destipo;
  set destipo(String? destipo) => _destipo = destipo;
  String? get despapel => _despapel;
  set despapel(String? despapel) => _despapel = despapel;
  String? get desautenticacao => _desautenticacao;
  set desautenticacao(String? desautenticacao) =>
      _desautenticacao = desautenticacao;
  String? get assinado => _assinado;
  set assinado(String? assinado) => _assinado = assinado;

  AssinanteFluxoModel.fromJson(Map<String, dynamic> json) {
    _idassinatura = json['idassinatura'];
    _idassinante = json['idassinante'];
    _desnome = json['desnome'];
    _descpf = json['descpf'];
    _desemail = json['desemail'];
    _destelefone = json['destelefone'];
    _dtassinatura = json['dtassinatura'];
    _destipo = json['destipo'];
    _despapel = json['despapel'];
    _desautenticacao = json['desautenticacao'];
    _assinado = json['assinado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idassinatura'] = this._idassinatura;
    data['idassinante'] = this._idassinante;
    data['desnome'] = this._desnome;
    data['descpf'] = this._descpf;
    data['desemail'] = this._desemail;
    data['destelefone'] = this._destelefone;
    data['dtassinatura'] = this._dtassinatura;
    data['destipo'] = this._destipo;
    data['despapel'] = this._despapel;
    data['desautenticacao'] = this._desautenticacao;
    data['assinado'] = this._assinado;
    return data;
  }
}
