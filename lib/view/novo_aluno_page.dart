import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/controller/aluno_controller.dart';
import 'package:meuapp/model/aluno_model.dart';

class NovoAlunoPage extends StatefulWidget {
  const NovoAlunoPage({super.key});

  @override
  State<NovoAlunoPage> createState() => _NovoAlunoPageState();
}

class _NovoAlunoPageState extends State<NovoAlunoPage> {
  Color myWhiteColor = const Color(0xFF979797);
  Color myDarkColor = const Color(0xFF212C34);

  AlunoController controller = AlunoController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController textNomeController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textIdadeController = TextEditingController();

  postNewAluno() async {
    try {
      await controller.postNovoAluno(
        AlunoEntity(
          nome: textNomeController.text,
          email: textEmailController.text,
          idade: textIdadeController.text != '' 
              ? int.parse(textIdadeController.text)
              : null,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Aluno"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 15),
          child: Column(
            children: [
              TextFormField(
                controller: textNomeController,
                cursorColor: Colors.white,
                style: TextStyle(color: myWhiteColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 17),
                  filled: true,
                  fillColor: myDarkColor,
                  hintText: 'Informe o nome',
                  hintStyle: TextStyle(color: myWhiteColor),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textEmailController,
                cursorColor: Colors.white,
                style: TextStyle(color: myWhiteColor),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 17),
                  filled: true,
                  fillColor: myDarkColor,
                  hintText: 'Informe o email',
                  hintStyle: TextStyle(color: myWhiteColor),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o email..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textIdadeController,
                cursorColor: Colors.white,
                style: TextStyle(color: myWhiteColor),
                //adicionar isso aqui só depois que der erro de conversao
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                //////////////////////////////////////
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 17),
                  filled: true,
                  fillColor: myDarkColor,
                  hintText: 'Informe a idade',
                  hintStyle: TextStyle(color: myWhiteColor),
                ),
                // The validator receives the text that the user has entered.
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 45,
                child: ElevatedButton(
                  //copiar da tela de login
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      //aqui enviar para api os dados
                      postNewAluno();
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
