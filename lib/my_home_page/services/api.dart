import 'dart:convert';

import 'package:assinador_invia/my_home_page/controllers/controllers.dart';
import 'package:assinador_invia/my_home_page/models/assinantes_fluxo_model.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_aguardando.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_finalizados.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_pendentes.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class MyHomePageApiServices extends ChangeNotifier {
  final _myHomePageController = MyHomePageController.instance;
  static MyHomePageApiServices _instance = MyHomePageApiServices();

  static MyHomePageApiServices get instance => _instance;

  Future<List<FluxoAguardandoModel>> getFluxosAguardando() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/aguardandoAssinatura.php');
      final payload = jsonEncode(
        {
          "apiPassword": "4pZqfXa3r88SW3aPr",
          "userCPF": "86521551000",
        },
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        return jsonObject
            .map(
              (fluxo) => FluxoAguardandoModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxoAguardandoModel>();
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }

  Future<List<FluxosPendentesModel>> getFluxosPendentes() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/fluxosPendentes.php');
      final payload = jsonEncode(
        {"apiPassword": "4pZqfXa3r88SW3aPr", "idUser": 7},
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        List<FluxosPendentesModel> fluxosPendentesModel = jsonObject
            .map(
              (fluxo) => FluxosPendentesModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxosPendentesModel>();
        return fluxosPendentesModel;
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }

  Future<List<FluxosFinalizadosModel>> getFluxosFinalizados() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/fluxosFinalizados.php');
      final payload = jsonEncode(
        {"apiPassword": "4pZqfXa3r88SW3aPr", "idUser": "32"},
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        return jsonObject
            .map(
              (fluxo) => FluxosFinalizadosModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxosFinalizadosModel>();
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }

  Future<List<AssinanteFluxoModel>> getAssinantes({
    required String idFluxo,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
        'POST',
        Uri.parse(
          'https://invianf.com.br/ws/appAssinador/assinantesFluxo.php',
        ),
      );
      request.body = json.encode(
        {
          "apiPassword": "4pZqfXa3r88SW3aPr",
          "idFluxo": idFluxo,
        },
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var json = jsonDecode(responseBody)["Results"];
        List<AssinanteFluxoModel> assinantesFluxoModel = json
            .map((assinante) => AssinanteFluxoModel.fromJson(assinante))
            .toList()
            .cast<AssinanteFluxoModel>();
        return assinantesFluxoModel;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stack) {
      print(e.toString() + "\n$stack");
    }
    return [];
  }

  Future<void> sendEmailToSigners({
    required List<AssinanteFluxoModel> assinantes,
    required String remetente,
    required String linkAssinatura,
    required String nameDocumento,
  }) async {
    String usuarioLogado = "86521651000";
    for (var assinante in assinantes) {
      if (assinante.assinado == "1") {
        print("Já assinou");
      } else {
        final headers = {
          'api-key':
              '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'
        };
        final endpoint = Uri.parse("https://api.sendinblue.com/v3/smtp/email");
        final payload = jsonEncode({
          "sender": {
            "name": "Equipe INVIA ASSINADOR",
            "email": "webpki@webpki.com.br"
          },
          "to": [
            {
              "email": "${assinante.desemail}",
              "name": "${assinante.desnome}",
            },
            {
              "email": "desenvolvimento1@invia.com.br",
              "name": "MARCOS FELIPE FREITAS DE FREITAS",
            },
          ],
          "subject": "Novo documento necessita de sua atenção",
          "htmlContent":
              "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html dir='ltr' xmlns='http://www.w3.org/1999/xhtml' xmlns:o='urn:schemas-microsoft-com:office:office' lang='pt'><head><meta charset='UTF-8' /><meta content='width=device-width, initial-scale=1' name='viewport' /><meta name='x-apple-disable-message-reformatting' /><meta http-equiv='X-UA-Compatible' content='IE=edge' /><meta content='telephone=no' name='format-detection' /><title>Novo modelo</title><style type='text/css'>#outlook a{ padding: 0} .es-button{ mso-style-priority: 100 !important; text-decoration: none !important} a[x-apple-data-detectors]{ color: inherit !important; text-decoration: none !important; font-size: inherit !important; font-family: inherit !important; font-weight: inherit !important; line-height: inherit !important} .es-desk-hidden{ display: none; float: left; overflow: hidden; width: 0; max-height: 0; line-height: 0; mso-hide: all} @media only screen and (max-width: 600px){ p, ul li, ol li, a{ line-height: 150% !important} h1, h2, h3, h1 a, h2 a, h3 a{ line-height: 120%} h1{ font-size: 36px !important; text-align: left} h2{ font-size: 26px !important; text-align: left} h3{ font-size: 20px !important; text-align: left} .es-header-body h1 a, .es-content-body h1 a, .es-footer-body h1 a{ font-size: 36px !important; text-align: left} .es-header-body h2 a, .es-content-body h2 a, .es-footer-body h2 a{ font-size: 26px !important; text-align: left} .es-header-body h3 a, .es-content-body h3 a, .es-footer-body h3 a{ font-size: 20px !important; text-align: left} .es-menu td a{ font-size: 12px !important} .es-header-body p, .es-header-body ul li, .es-header-body ol li, .es-header-body a{ font-size: 14px !important} .es-content-body p, .es-content-body ul li, .es-content-body ol li, .es-content-body a{ font-size: 16px !important} .es-footer-body p, .es-footer-body ul li, .es-footer-body ol li, .es-footer-body a{ font-size: 14px !important} .es-infoblock p, .es-infoblock ul li, .es-infoblock ol li, .es-infoblock a{ font-size: 12px !important} *[class='gmail-fix']{ display: none !important} .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3{ text-align: center !important} .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3{ text-align: right !important} .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3{ text-align: left !important} .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img{ display: inline !important} .es-button-border{ display: inline-block !important} a.es-button, button.es-button{ font-size: 20px !important; display: inline-block !important} .es-adaptive table, .es-left, .es-right{ width: 100% !important} .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header{ width: 100% !important; max-width: 600px !important} .es-adapt-td{ display: block !important; width: 100% !important} .adapt-img{ width: 100% !important; height: auto !important} .es-m-p0{ padding: 0 !important} .es-m-p0r{ padding-right: 0 !important} .es-m-p0l{ padding-left: 0 !important} .es-m-p0t{ padding-top: 0 !important} .es-m-p0b{ padding-bottom: 0 !important} .es-m-p20b{ padding-bottom: 20px !important} .es-mobile-hidden, .es-hidden{ display: none !important} tr.es-desk-hidden, td.es-desk-hidden, table.es-desk-hidden{ width: auto !important; overflow: visible !important; float: none !important; max-height: inherit !important; line-height: inherit !important} tr.es-desk-hidden{ display: table-row !important} table.es-desk-hidden{ display: table !important} td.es-desk-menu-hidden{ display: table-cell !important} .es-menu td{ width: 1% !important} table.es-table-not-adapt, .esd-block-html table{ width: auto !important} table.es-social{ display: inline-block !important} table.es-social td{ display: inline-block !important} .es-m-p5{ padding: 5px !important} .es-m-p5t{ padding-top: 5px !important} .es-m-p5b{ padding-bottom: 5px !important} .es-m-p5r{ padding-right: 5px !important} .es-m-p5l{ padding-left: 5px !important} .es-m-p10{ padding: 10px !important} .es-m-p10t{ padding-top: 10px !important} .es-m-p10b{ padding-bottom: 10px !important} .es-m-p10r{ padding-right: 10px !important} .es-m-p10l{ padding-left: 10px !important} .es-m-p15{ padding: 15px !important} .es-m-p15t{ padding-top: 15px !important} .es-m-p15b{ padding-bottom: 15px !important} .es-m-p15r{ padding-right: 15px !important} .es-m-p15l{ padding-left: 15px !important} .es-m-p20{ padding: 20px !important} .es-m-p20t{ padding-top: 20px !important} .es-m-p20r{ padding-right: 20px !important} .es-m-p20l{ padding-left: 20px !important} .es-m-p25{ padding: 25px !important} .es-m-p25t{ padding-top: 25px !important} .es-m-p25b{ padding-bottom: 25px !important} .es-m-p25r{ padding-right: 25px !important} .es-m-p25l{ padding-left: 25px !important} .es-m-p30{ padding: 30px !important} .es-m-p30t{ padding-top: 30px !important} .es-m-p30b{ padding-bottom: 30px !important} .es-m-p30r{ padding-right: 30px !important} .es-m-p30l{ padding-left: 30px !important} .es-m-p35{ padding: 35px !important} .es-m-p35t{ padding-top: 35px !important} .es-m-p35b{ padding-bottom: 35px !important} .es-m-p35r{ padding-right: 35px !important} .es-m-p35l{ padding-left: 35px !important} .es-m-p40{ padding: 40px !important} .es-m-p40t{ padding-top: 40px !important} .es-m-p40b{ padding-bottom: 40px !important} .es-m-p40r{ padding-right: 40px !important} .es-m-p40l{ padding-left: 40px !important} .es-desk-hidden{ display: table-row !important; width: auto !important; overflow: visible !important; max-height: inherit !important} .h-auto{ height: auto !important}} @media screen and (max-width: 384px){ .mail-message-content{ width: 414px !important}} </style></head><body style=' width: 100%; font-family: arial, helvetica neue, helvetica, sans-serif; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; padding: 0; margin: 0; ' ><div dir='ltr' class='es-wrapper-color' lang='pt' style='background-color: #fafafa' ><table class='es-wrapper' width='100%' cellspacing='0' cellpadding='0' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; padding: 0; margin: 0; width: 100%; height: 100%; background-repeat: repeat; background-position: center top; background-color: #fafafa; ' ><tr><td valign='top' style='padding: 0; margin: 0'><table cellpadding='0' cellspacing='0' class='es-content' align='center' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; table-layout: fixed !important; width: 100%; ' ><tr><td class='es-info-area' align='center' style='padding: 0; margin: 0' ><table class='es-content-body' align='center' cellpadding='0' cellspacing='0' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; background-color: transparent; width: 600px; ' bgcolor='#FFFFFF' role='none' ><tr><td align='left' style='padding: 20px; margin: 0'><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' valign='top' style='padding: 0; margin: 0; width: 560px' ><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' style='padding: 0; margin: 0; display: none' ></td></tr></table></td></tr></table></td></tr></table></td></tr></table><table cellpadding='0' cellspacing='0' class='es-header' align='center' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; table-layout: fixed !important; width: 100%; background-color: transparent; background-repeat: repeat; background-position: center top; ' ><tr><td align='center' style='padding: 0; margin: 0'><table bgcolor='#ffffff' class='es-header-body' align='center' cellpadding='0' cellspacing='0' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; background-color: transparent; width: 600px; ' ><tr><td align='left' style=' margin: 0; padding-top: 10px; padding-bottom: 10px; padding-left: 20px; padding-right: 20px; ' ><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td class='es-m-p0r' valign='top' align='center' style='padding: 0; margin: 0; width: 560px' ><table cellpadding='0' cellspacing='0' width='100%' role='presentation' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' style=' padding: 0; margin: 0; padding-bottom: 20px; font-size: 0px; ' ><img src='https://www.invia.com.br/cert/assets/images/logotipo-sem-fundo-horizontal-5181x944teste.png' alt='Logo' style=' display: block; border: 0; outline: none; text-decoration: none; -ms-interpolation-mode: bicubic; font-size: 12px; ' width='330' title='Logo' height='60' /></td></tr></table></td></tr></table></td></tr></table></td></tr></table><table cellpadding='0' cellspacing='0' class='es-content' align='center' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; table-layout: fixed !important; width: 100%; ' ><tr><td align='center' style='padding: 0; margin: 0'><table bgcolor='#ffffff' class='es-content-body' align='center' cellpadding='0' cellspacing='0' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; background-color: #ffffff; width: 600px; ' ><tr><td align='left' style=' margin: 0; padding-bottom: 20px; padding-left: 20px; padding-right: 20px; padding-top: 30px; ' ><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' valign='top' style='padding: 0; margin: 0; width: 560px' ><table cellpadding='0' cellspacing='0' width='100%' role='presentation' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' class='es-m-txt-l' style=' padding: 0; margin: 0; padding-bottom: 10px; ' ><h1 style=' margin: 0; line-height: 55px; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; font-size: 46px; font-style: normal; font-weight: bold; color: #333333; ' >Documento aguardando sua assinatura </h1></td></tr><tr><td align='left' style=' margin: 0; padding-top: 5px; padding-bottom: 5px; padding-left: 15px; padding-right: 15px; ' ><p style=' margin: 0; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; line-height: 28px; margin-bottom: 15px; color: #333333; font-size: 14px; ' >Prezado(a) ${assinante.desnome}, </p><p style=' margin: 0; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; line-height: 28px; margin-bottom: 15px; color: #333333; font-size: 14px; ' >Esperamos que esteja bem. Gostaríamos de informar que há uma pendência de assinatura em um documento importante. Pedimos gentilmente que revise e assine o documento o mais breve possível. </p><p style=' margin: 0; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; line-height: 28px; margin-bottom: 15px; color: #333333; font-size: 14px; ' >Agradecemos pela atenção e estamos à disposição para qualquer dúvida. </p></td></tr><tr><td align='center' style=' padding: 0; margin: 0; padding-top: 5px; padding-bottom: 5px; ' ><p style=' margin: 0; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; line-height: 42px; margin-bottom: 15px; color: #333333; font-size: 28px; ' ><strong>Outros assinantes:</strong></p></td></tr><tr><td align='center' style=' padding: 20px; margin: 0; font-size: 0; ' ><table border='0' width='100%' height='100%' cellpadding='0' cellspacing='0' role='presentation' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td style=' padding: 0; margin: 0; border-bottom: 1px solid #cccccc; background: unset; height: 1px; width: 100%; margin: 0px; ' ></td></tr></table></td></tr><tr><td align='left' style='padding: 20px; margin: 0' >${assinantes.map((assinante) => assinante.descpf != usuarioLogado ? '<p style=margin: 0; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; font-family: arial, helvetica neue, helvetica, sans-serif; line-height: 28px; margin-bottom: 15px; color: #0c0c0c; font-size: 14px;> Nome: ${assinante.desnome}<br />E-mail: ${assinante.desemail}<br />Telefone: ${assinante.destelefone}' : "").toList().join(',')} </p></td></tr><tr><td align='center' style=' padding: 0; margin: 0; padding-top: 10px; padding-bottom: 10px; font-size: 0px; ' ><img class='adapt-img' src='https://invianf.com.br/inviassinador/dist/img/logoassinador.png' alt style=' display: block; border: 0; outline: none; text-decoration: none; -ms-interpolation-mode: bicubic; ' width='260' height='108' /></td></tr><tr><td align='center' style=' padding: 0; margin: 0; padding-top: 10px; padding-bottom: 10px; ' ><span class='es-button-border' style=' border-style: solid; border-color: #5c68e2; background: #5c68e2; border-width: 2px; display: inline-block; border-radius: 5px; width: auto; ' ><a href='${linkAssinatura}' class='es-button' target='_blank' style=' mso-style-priority: 100 !important; text-decoration: none; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; mso-line-height-rule: exactly; color: #ffffff; font-size: 20px; padding: 10px 30px 10px 30px; display: inline-block; background: #5c68e2; border-radius: 5px; font-family: arial, helvetica neue, helvetica, sans-serif; font-weight: normal; font-style: normal; line-height: 24px; width: auto; text-align: center; mso-padding-alt: 0; mso-border-alt: 10px solid #5c68e2; padding-left: 30px; padding-right: 30px; ' >Assinar documento</a ></span ></td></tr></table></td></tr></table></td></tr><tr><td align='left' style=' padding: 0; margin: 0; padding-top: 20px; padding-left: 20px; padding-right: 20px; ' ><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' valign='top' style='padding: 0; margin: 0; width: 560px' ><table cellpadding='0' cellspacing='0' width='100%' role='none' style=' mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; border-spacing: 0px; ' ><tr><td align='center' style='padding: 0; margin: 0; display: none' ></td></tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table></div></body></html>"
        });
        http.Response response =
            await http.post(endpoint, body: payload, headers: headers);
        if (response.statusCode == 200) {
          print(response.body);
        } else {
          print(response.body);
        }
      }
    }
  }
}
