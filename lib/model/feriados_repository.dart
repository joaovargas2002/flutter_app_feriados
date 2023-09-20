import 'dart:convert';
import 'package:meuapp/model/feriados_model.dart';
import 'package:meuapp/utils/constantes.dart';
import 'package:http/http.dart' as http;

class FeriadosRepository {
  List<FeriadosEntity> feriados = [];
  final url = Uri.parse('$urlBrasilApi');

  Future<List<FeriadosEntity>> getAll() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final FeriadosList = jsonDecode(response.body) as List;
      for (var feriado in FeriadosList) {
        feriados.add(FeriadosEntity.mapToEntity(feriado));
      }
    }
    return feriados;
  }
}
