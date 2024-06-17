class FluxosPendentesModel {
  String? _idassinatura;
  String? _idcriador;
  String? _desdocnome;
  String? _desdescricao;
  String? _descategoria;
  String? _desdocoriginal;
  String? _desdocassinado;
  String? _numassinantes;
  String? _numassinaturas;
  String? _dtcadastro;
  String? _finalizado;
  String? _dtLimite;
  String? _dtfinalizado;

  FluxosPendentesModel(
      {String? idassinatura,
      String? idcriador,
      String? desdocnome,
      String? desdescricao,
      String? descategoria,
      String? desdocoriginal,
      String? desdocassinado,
      String? numassinantes,
      String? numassinaturas,
      String? dtcadastro,
      String? finalizado,
      String? dtLimite,
      String? dtfinalizado}) {
    if (idassinatura != null) {
      this._idassinatura = idassinatura;
    }
    if (idcriador != null) {
      this._idcriador = idcriador;
    }
    if (desdocnome != null) {
      this._desdocnome = desdocnome;
    }
    if (desdescricao != null) {
      this._desdescricao = desdescricao;
    }
    if (descategoria != null) {
      this._descategoria = descategoria;
    }
    if (desdocoriginal != null) {
      this._desdocoriginal = desdocoriginal;
    }
    if (desdocassinado != null) {
      this._desdocassinado = desdocassinado;
    }
    if (numassinantes != null) {
      this._numassinantes = numassinantes;
    }
    if (numassinaturas != null) {
      this._numassinaturas = numassinaturas;
    }
    if (dtcadastro != null) {
      this._dtcadastro = dtcadastro;
    }
    if (finalizado != null) {
      this._finalizado = finalizado;
    }
    if (dtLimite != null) {
      this._dtLimite = dtLimite;
    }
    if (dtfinalizado != null) {
      this._dtfinalizado = dtfinalizado;
    }
  }

  String? get idassinatura => _idassinatura;

  set idassinatura(String? idassinatura) => _idassinatura = idassinatura;

  String? get idcriador => _idcriador;

  set idcriador(String? idcriador) => _idcriador = idcriador;

  String? get desdocnome => _desdocnome;

  set desdocnome(String? desdocnome) => _desdocnome = desdocnome;

  String? get desdescricao => _desdescricao;

  set desdescricao(String? desdescricao) => _desdescricao = desdescricao;

  String? get descategoria => _descategoria;

  set descategoria(String? descategoria) => _descategoria = descategoria;

  String? get desdocoriginal => _desdocoriginal;

  set desdocoriginal(String? desdocoriginal) =>
      _desdocoriginal = desdocoriginal;

  String? get desdocassinado => _desdocassinado;

  set desdocassinado(String? desdocassinado) =>
      _desdocassinado = desdocassinado;

  String? get numassinantes => _numassinantes;

  set numassinantes(String? numassinantes) => _numassinantes = numassinantes;

  String? get numassinaturas => _numassinaturas;

  set numassinaturas(String? numassinaturas) =>
      _numassinaturas = numassinaturas;

  String? get dtcadastro => _dtcadastro;

  set dtcadastro(String? dtcadastro) => _dtcadastro = dtcadastro;

  String? get finalizado => _finalizado;

  set finalizado(String? finalizado) => _finalizado = finalizado;

  String? get dtLimite => _dtLimite;

  set dtLimite(String? dtLimite) => _dtLimite = dtLimite;

  String? get dtfinalizado => _dtfinalizado;

  set dtfinalizado(String? dtfinalizado) => _dtfinalizado = dtfinalizado;

  FluxosPendentesModel.fromJson(Map<String, dynamic> json) {
    _idassinatura = json['idassinatura'];
    _idcriador = json['idcriador'];
    _desdocnome = json['desdocnome'];
    _desdescricao = json['desdescricao'];
    _descategoria = json['descategoria'];
    _desdocoriginal = json['desdocoriginal'];
    _desdocassinado = json['desdocassinado'];
    _numassinantes = json['numassinantes'];
    _numassinaturas = json['numassinaturas'];
    _dtcadastro = json['dtcadastro'];
    _finalizado = json['finalizado'];
    _dtLimite = json['dt_limite'];
    _dtfinalizado = json['dtfinalizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idassinatura'] = this._idassinatura;
    data['idcriador'] = this._idcriador;
    data['desdocnome'] = this._desdocnome;
    data['desdescricao'] = this._desdescricao;
    data['descategoria'] = this._descategoria;
    data['desdocoriginal'] = this._desdocoriginal;
    data['desdocassinado'] = this._desdocassinado;
    data['numassinantes'] = this._numassinantes;
    data['numassinaturas'] = this._numassinaturas;
    data['dtcadastro'] = this._dtcadastro;
    data['finalizado'] = this._finalizado;
    data['dt_limite'] = this._dtLimite;
    data['dtfinalizado'] = this._dtfinalizado;
    return data;
  }
}

class FluxoFinalizadoModel {
  String? _idassinatura;
  String? _idcriador;
  String? _desdocnome;
  String? _desdescricao;
  String? _descategoria;
  String? _desdocoriginal;
  String? _desdocassinado;
  String? _numassinantes;
  String? _numassinaturas;
  String? _dtcadastro;
  String? _finalizado;
  String? _dtLimite;
  String? _dtfinalizado;

  FluxoFinalizadoModel(
      {String? idassinatura,
      String? idcriador,
      String? desdocnome,
      String? desdescricao,
      String? descategoria,
      String? desdocoriginal,
      String? desdocassinado,
      String? numassinantes,
      String? numassinaturas,
      String? dtcadastro,
      String? finalizado,
      String? dtLimite,
      String? dtfinalizado}) {
    if (idassinatura != null) {
      this._idassinatura = idassinatura;
    }
    if (idcriador != null) {
      this._idcriador = idcriador;
    }
    if (desdocnome != null) {
      this._desdocnome = desdocnome;
    }
    if (desdescricao != null) {
      this._desdescricao = desdescricao;
    }
    if (descategoria != null) {
      this._descategoria = descategoria;
    }
    if (desdocoriginal != null) {
      this._desdocoriginal = desdocoriginal;
    }
    if (desdocassinado != null) {
      this._desdocassinado = desdocassinado;
    }
    if (numassinantes != null) {
      this._numassinantes = numassinantes;
    }
    if (numassinaturas != null) {
      this._numassinaturas = numassinaturas;
    }
    if (dtcadastro != null) {
      this._dtcadastro = dtcadastro;
    }
    if (finalizado != null) {
      this._finalizado = finalizado;
    }
    if (dtLimite != null) {
      this._dtLimite = dtLimite;
    }
    if (dtfinalizado != null) {
      this._dtfinalizado = dtfinalizado;
    }
  }

  String? get idassinatura => _idassinatura;

  set idassinatura(String? idassinatura) => _idassinatura = idassinatura;

  String? get idcriador => _idcriador;

  set idcriador(String? idcriador) => _idcriador = idcriador;

  String? get desdocnome => _desdocnome;

  set desdocnome(String? desdocnome) => _desdocnome = desdocnome;

  String? get desdescricao => _desdescricao;

  set desdescricao(String? desdescricao) => _desdescricao = desdescricao;

  String? get descategoria => _descategoria;

  set descategoria(String? descategoria) => _descategoria = descategoria;

  String? get desdocoriginal => _desdocoriginal;

  set desdocoriginal(String? desdocoriginal) =>
      _desdocoriginal = desdocoriginal;

  String? get desdocassinado => _desdocassinado;

  set desdocassinado(String? desdocassinado) =>
      _desdocassinado = desdocassinado;

  String? get numassinantes => _numassinantes;

  set numassinantes(String? numassinantes) => _numassinantes = numassinantes;

  String? get numassinaturas => _numassinaturas;

  set numassinaturas(String? numassinaturas) =>
      _numassinaturas = numassinaturas;

  String? get dtcadastro => _dtcadastro;

  set dtcadastro(String? dtcadastro) => _dtcadastro = dtcadastro;

  String? get finalizado => _finalizado;

  set finalizado(String? finalizado) => _finalizado = finalizado;

  String? get dtLimite => _dtLimite;

  set dtLimite(String? dtLimite) => _dtLimite = dtLimite;

  String? get dtfinalizado => _dtfinalizado;

  set dtfinalizado(String? dtfinalizado) => _dtfinalizado = dtfinalizado;

  FluxoFinalizadoModel.fromJson(Map<String, dynamic> json) {
    _idassinatura = json['idassinatura'];
    _idcriador = json['idcriador'];
    _desdocnome = json['desdocnome'];
    _desdescricao = json['desdescricao'];
    _descategoria = json['descategoria'];
    _desdocoriginal = json['desdocoriginal'];
    _desdocassinado = json['desdocassinado'];
    _numassinantes = json['numassinantes'];
    _numassinaturas = json['numassinaturas'];
    _dtcadastro = json['dtcadastro'];
    _finalizado = json['finalizado'];
    _dtLimite = json['dt_limite'];
    _dtfinalizado = json['dtfinalizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idassinatura'] = this._idassinatura;
    data['idcriador'] = this._idcriador;
    data['desdocnome'] = this._desdocnome;
    data['desdescricao'] = this._desdescricao;
    data['descategoria'] = this._descategoria;
    data['desdocoriginal'] = this._desdocoriginal;
    data['desdocassinado'] = this._desdocassinado;
    data['numassinantes'] = this._numassinantes;
    data['numassinaturas'] = this._numassinaturas;
    data['dtcadastro'] = this._dtcadastro;
    data['finalizado'] = this._finalizado;
    data['dt_limite'] = this._dtLimite;
    data['dtfinalizado'] = this._dtfinalizado;
    return data;
  }
}

class FluxoAguardandoModel {
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
  String? _signLink;

  FluxoAguardandoModel(
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
      String? assinado,
      String? signLink}) {
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
    if (signLink != null) {
      this._signLink = signLink;
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

  String? get signLink => _signLink;

  set signLink(String? signLink) => _signLink = signLink;

  FluxoAguardandoModel.fromJson(Map<String, dynamic> json) {
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
    _signLink = json['signLink'];
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
    data['signLink'] = this._signLink;
    return data;
  }
}
