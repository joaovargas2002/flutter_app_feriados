import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/controller/feriados_controller.dart';
import 'package:meuapp/model/feriados_model.dart';
import 'package:meuapp/view/login_page.dart';


class FeriadosPage extends StatefulWidget {
  const FeriadosPage({super.key});

  @override
  State<FeriadosPage> createState() => _FeriadosPageState();
}

class _FeriadosPageState extends State<FeriadosPage> {
  FeriadosController controller = FeriadosController();

  late Future<List<FeriadosEntity>> future;

  Future<List<FeriadosEntity>> getFeriados() async {
    Future<List<FeriadosEntity>> lista = controller.getFeriadosList();
    return lista;
  }

  @override
  void initState() {
    super.initState();
    future = getFeriados();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
        title: const Text("Feriados em 2023"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FeriadosEntity>>(
        future: future,
        builder: (BuildContext context,
            AsyncSnapshot<List<FeriadosEntity>> snapshot) {
          if (snapshot.hasData) {
            //tem dados, monta o list view
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Slidable(
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                          icon: Icons.edit,
                          label: "Alterar",
                        ),
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: "Excluir",
                        ),
                      ],
                    ),
                    child: ListTile(
                      
                      title: Align(alignment: Alignment.center,
                      child:Text("${snapshot.data![index].name}",),
                      ),
                      
                      subtitle: Align(alignment: Alignment.center,
                      child: Text("${snapshot.data![index].date}"),)
                      
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


