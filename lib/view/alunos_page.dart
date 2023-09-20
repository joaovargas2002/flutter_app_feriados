import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/controller/aluno_controller.dart';
import 'package:meuapp/model/aluno_model.dart';
import 'package:meuapp/view/drawer.dart';
import 'package:meuapp/view/login_page.dart';
import 'package:meuapp/view/novo_aluno_page.dart';

class AlunosPage extends StatefulWidget {
  const AlunosPage({super.key});

  @override
  State<AlunosPage> createState() => _AlunosPageState();
}

class _AlunosPageState extends State<AlunosPage> {
  AlunoController controller = AlunoController();

  late Future<List<AlunoEntity>> future;

  @override
  void initState() {
    super.initState();
    future = getAlunos();
  }

  Future<List<AlunoEntity>> getAlunos() async {
    Future<List<AlunoEntity>> lista = controller.alunoRepository.getAll();
    return lista;
  }

  //1 trocar os temas
  //2 trocar o spinner color
  //3 wrap card
  //4 wrap list tile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
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
        title: const Center(
          child: Text("Alunos"),
        ),
      ),
      //future builder constroi e atualiza o widget conforme o estado
      // retornado pela sua "future" através do "snapshot"
      // ou seja -> em loading, completado, tem dados, não tem dados)
      body: FutureBuilder<List<AlunoEntity>>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<List<AlunoEntity>> snapshot) {
          //se o snapshot atual da future possui dados
          if (snapshot.hasData) {
            //ja cria um scroll view
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                          icon: Icons.edit,
                          label: 'Alterar',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmação'),
                                  content: const Text(
                                    'Deseja excluir esse aluno?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text('Confirmar'),
                                      onPressed: () async {
                                        //chamada da exclusão....
                                        try {
                                          await controller.deleteAluno(
                                              int.parse(
                                                  snapshot.data![index].id!));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Aluno excluído com sucesso!'),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text('$e')),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                              //aqui quando fecha o dialog
                            ).then((value) {
                              future = getAlunos();
                              setState(() => {});
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Excluir',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: Text('A'),
                        // Text(snapshot.data![index].nome![0]),
                      ),
                      title: Text("${snapshot.data![index].nome}"),
                      subtitle: Text("${snapshot.data![index].email}"),
                    ),
                  ),
                );
              },
            );
            //senão (não tem dados, está em loading, tem erro, etc) então
            // esse else não é o ideal, pode ser melhorado...
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovoAlunoPage(),
            ),
          ).then((value) {
            future = getAlunos();
            setState(() => {});
          });
        },
      ),
    );
  }
}
