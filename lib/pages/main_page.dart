import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_number_gen/logic/random_logic.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _startController = TextEditingController();
  final _endController = TextEditingController();

  final _startFocusNode = FocusNode();
  final _endFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    _startFocusNode.addListener(() {
      if (_startFocusNode.hasFocus) {
        _startController.selection = TextSelection(
            baseOffset: 0, extentOffset: _startController.text.length);
      }
    });
    _endFocusNode.addListener(() {
      if (_endFocusNode.hasFocus) {
        _endController.selection = TextSelection(
            baseOffset: 0, extentOffset: _endController.text.length);
      }
    });

    _startController.text = context.read<RandomLogic>().start;
    _endController.text = context.read<RandomLogic>().end;

    return Scaffold(
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(16),
                width: 512,
                height: 1024,
                child: (Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      focusNode: _startFocusNode,
                      controller: _startController,
                      // initialValue: context.read<RandomLogic>().start,
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
                      focusNode: _endFocusNode,
                      controller: _endController,
                      // initialValue: context.read<RandomLogic>().end,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          context.read<RandomLogic>().end = value,
                      onFieldSubmitted: (value) =>
                          context.read<RandomLogic>().generate(),
                      // onTap: () => _endController.selection = TextSelection(
                      //     baseOffset: 0,
                      //     extentOffset: _endController.value.text.length),
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
                        child: const Text("ГЕНЕРИРОВАТЬ")),
                  ],
                )))));
  }
}
