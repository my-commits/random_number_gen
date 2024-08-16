import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_number_gen/logic/random_logic.dart';
import 'package:random_number_gen/main.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                margin: EdgeInsets.all(16),
                width: 512,
                height: 1024,
                child: (Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      initialValue: context.read<RandomLogic>().start,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          context.read<RandomLogic>().start = value,
                      onFieldSubmitted: (value) =>
                          context.read<RandomLogic>().generate(),
                      decoration: InputDecoration(
                        labelText: "Начальное значение",
                        errorText: context.watch<RandomLogic>().startError
                            ? "Неверное значение"
                            : null,
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      initialValue: context.read<RandomLogic>().end,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          context.read<RandomLogic>().end = value,
                      onFieldSubmitted: (value) =>
                          context.read<RandomLogic>().generate(),
                      decoration: InputDecoration(
                        labelText: "Начальное значение",
                        errorText: context.watch<RandomLogic>().endError
                            ? "Неверное значение"
                            : null,
                      ),
                    ),
                    Text(
                        style: Theme.of(context).textTheme.displaySmall,
                        context.watch<RandomLogic>().result),
                    FilledButton(
                        onPressed: () {
                          context.read<RandomLogic>().generate();
                          HapticFeedback.vibrate();
                        },
                        child: Text("ГЕНЕРИРОВАТЬ")),
                  ],
                )))));
  }
}
