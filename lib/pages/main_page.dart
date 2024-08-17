import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_number_gen/logic/random_logic.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _startController = TextEditingController(text: "1");
  final _endController = TextEditingController(text: "10");

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

    return Scaffold(
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(16),
                width: 512,
                height: 1024,
                child: (Column(
                  mainAxisAlignment:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              style: Theme.of(context).textTheme.displaySmall,
                              context.watch<RandomLogic>().result),
                          IconButton(
                              onPressed: () => Clipboard.setData(ClipboardData(
                                  text: context.read<RandomLogic>().result)),
                              icon: const Icon(Icons.copy))
                        ]),
                    TextFormField(
                      focusNode: _startFocusNode,
                      controller: _startController,
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
                      focusNode: _endFocusNode,
                      controller: _endController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) =>
                          context.read<RandomLogic>().end = value,
                      onFieldSubmitted: (value) =>
                          context.read<RandomLogic>().generate(),
                      decoration: InputDecoration(
                        labelText: "Конечное значение",
                        errorText: context.watch<RandomLogic>().endError
                            ? "Неверное значение"
                            : null,
                      ),
                    ),
                    const SizedBox(height: 32),
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
