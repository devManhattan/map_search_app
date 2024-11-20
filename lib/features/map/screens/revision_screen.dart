import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_konsi/core/messages.dart';
import 'package:test_konsi/features/map/bloc/save_favorite/bloc/save_favorite_bloc.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/global/widgets/rounded_button.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key, required this.location});
  final Location location;

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  final SaveFavoriteBloc saveFavoriteBloc = GetIt.I.get<SaveFavoriteBloc>();

  final TextEditingController cep = TextEditingController();

  final TextEditingController endereco = TextEditingController();

  final TextEditingController numero = TextEditingController();

  final TextEditingController complemento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cep.text = widget.location.cep;
    endereco.text = widget.location.logradouro;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Revisão",
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider.value(
          value: saveFavoriteBloc,
          child: BlocConsumer<SaveFavoriteBloc, SaveFavoriteState>(
            listener: (context, state) {
              if (state is SaveFavoriteLoaded) {
                scaffoldMensegerSuccess("Endereço salvo com suceso", context);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is SaveFavoriteLoading) {
                return const CircularProgressIndicator();
              }
              return LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: cep,
                        decoration: const InputDecoration(labelText: "CEP"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: endereco,
                        decoration:
                            const InputDecoration(labelText: "Endereço"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: numero,
                        decoration: const InputDecoration(labelText: "Número"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: complemento,
                        decoration:
                            const InputDecoration(labelText: "Complemento"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                            title: "Salvar",
                            action: () {
                              saveFavoriteBloc.add(ExecuteSaveFavoriteEvent(
                                  location: Location.fromJson(
                                {
                                  ...widget.location.toJson(),
                                  "cep": cep.text,
                                  "logradouro": endereco.text,
                                  "numero": numero.text,
                                  "complemento": complemento.text,
                                },
                              )));
                            }),
                      )
                    ],
                  ),
                );
              });
            },
          ),
        ),
      )),
    );
  }
}
