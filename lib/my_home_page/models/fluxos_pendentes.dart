import 'package:assinador_invia/my_home_page/models/assinantes_fluxo_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  IconData? _icon;
  List<AssinanteFluxoModel>? _assinantes;

  FluxosPendentesModel({
    String? idassinatura,
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
    String? dtfinalizado,
    List<AssinanteFluxoModel>? assinantes,
    IconData? icon = FontAwesomeIcons.fileCircleQuestion,
  }) {
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
    if (icon != null) {
      this._icon = icon;
    }
    if (assinantes != null) {
      this._assinantes = assinantes;
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
  List<AssinanteFluxoModel>? get assinantes => _assinantes;
  set assinantes(List<AssinanteFluxoModel>? assinantes) =>
      _assinantes = assinantes;
  IconData? get icon => _icon;
  set icon(IconData? icon) => _icon = icon;

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
    _assinantes = json['assinantes'];
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
    data['assinantes'] = this._assinantes;
    return data;
  }
}
