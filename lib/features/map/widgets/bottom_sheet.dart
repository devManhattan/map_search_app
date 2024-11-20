import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/features/map/router.dart';
import 'package:test_konsi/global/widgets/rounded_button.dart';

class BottomSheetLocation extends StatelessWidget {
  const BottomSheetLocation({super.key, required this.location});
  final Location location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.cep,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Text(
            "${location.logradouro} - ${location.localidade}, ${location.estado} - ${location.uf}",
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            height: 40,
            child: RoundedButton(
                title: 'Salvar endereço',
                action: () {
                  Navigator.pop(context);
                  context.push(MapRoutesEnum.revision.fullPath, extra: location);
                }),
          )
        ],
      ),
    );
  }
}
