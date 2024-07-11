import 'package:assinador_invia/my_home_page/models/fluxos_aguardando.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_finalizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices extends ChangeNotifier {
  static FirestoreServices _instance = FirestoreServices();

  static FirestoreServices get instance => _instance;
  Map<String, dynamic> _data = {
    "Aguardando": [{}],
  };
  Map<String, dynamic> _keys = {};

  Map<String, dynamic> get data => _data;

  Map<String, dynamic> get keys => _keys;
  static final db = FirebaseFirestore.instance;
  static final docRef = db.collection("04082099093").doc("recentes");
  static final keyRef = db.collection("04082099093").doc("keys");

  Future<void> setData(dynamic fluxos) async {
    if (fluxos is FluxoAguardandoModel) {
      await getData();
      if (_data["Aguardando"] != null) {
        _data["Aguardando"].add(fluxos.toJson());
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      } else {
        _data["Aguardando"] = ([fluxos.toJson()]);
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      }
    } else if (fluxos is FluxosFinalizadosModel) {
      await getData();
      if (_data["Finalizados"] != null) {
        _data["Finalizados"].add(fluxos.toJson());
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      } else {
        _data["Finalizados"] = [fluxos.toJson()];
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      }
    } else {
      await getData();
      if (_data["Pendentes"] != null) {
        _data["Pendentes"].add(fluxos.toJson());
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      } else {
        _data["Pendentes"] = ([fluxos.toJson()]);
        await db
            .collection(
              "04082099093",
            )
            .doc(
              "recentes",
            )
            .update(
              _data,
            )
            .onError(
              (e, _) => print(
                "Error writing document: $e",
              ),
            );
      }
    }
  }

  Future<void> getData() async {
    await docRef.get().then((DocumentSnapshot doc) => _data = doc.data() as Map<String, dynamic>);
  }

  Future<void> getKeys() async {
    await keyRef.get().then((DocumentSnapshot doc) => _data = doc.data() as Map<String, dynamic>);
  }
}
