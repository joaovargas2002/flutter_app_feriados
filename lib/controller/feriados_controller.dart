import 'package:meuapp/model/feriados_model.dart';
import 'package:meuapp/model/feriados_repository.dart';

class FeriadosController {
  FeriadosRepository feriadosRepository = FeriadosRepository();

  List<FeriadosEntity> feriadosList = [];

  Future <List<FeriadosEntity>>getFeriadosList() async {
    feriadosList = await feriadosRepository.getAll();
   
    return feriadosList;
  
  }
}
