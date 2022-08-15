import 'package:dpad_navigate/utils/action_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData _selectedIcon = Icons.ac_unit;
  FocusNode? firstFocus;
  FocusNode? secondFocus;
  FocusNode? thirdFocus;

  _changeFocus(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
    setState(() {});
  }

  _initFocus(BuildContext context) {
    if (firstFocus == null) {
      firstFocus = FocusNode();
      secondFocus = FocusNode();
      thirdFocus = FocusNode();
      FocusScope.of(context).requestFocus(firstFocus);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    firstFocus?.dispose();
    secondFocus?.dispose();
    thirdFocus?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (firstFocus == null) {
      _initFocus(context);
    }
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.select): CenterButtonIntent(),
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Icon(
              _selectedIcon,
              size: 200,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Actions(
                  actions: <Type, Action<Intent>>{
                    RightButtonIntent: CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                      _selectedIcon = Icons.account_balance_rounded;
                      return _changeFocus(context, secondFocus!);
                    })
                  },
                  child: Focus(
                    focusNode: firstFocus,
                    child: Container(
                      decoration: BoxDecoration(
                        border: !(firstFocus?.hasFocus ?? false) ? null : Border.all(color: Colors.orange),
                      ),
                      child: const Icon(
                        Icons.ac_unit,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                Actions(
                  actions: <Type, Action<Intent>>{
                    RightButtonIntent: CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                      _selectedIcon = Icons.tv;
                      return _changeFocus(context, thirdFocus!);
                    }),
                    LeftButtonIntent: CallbackAction<LeftButtonIntent>(onInvoke: (intent) {
                      _selectedIcon = Icons.ac_unit;
                      return _changeFocus(context, firstFocus!);
                    })
                  },
                  child: Focus(
                    focusNode: secondFocus,
                    child: Container(
                      decoration: BoxDecoration(
                        border: !(secondFocus?.hasFocus ?? false) ? null : Border.all(color: Colors.orange),
                      ),
                      child: const Icon(
                        Icons.account_balance_rounded,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                Actions(
                  actions: <Type, Action<Intent>>{
                    RightButtonIntent: CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                      _selectedIcon = Icons.ac_unit;
                      return _changeFocus(context, firstFocus!);
                    }),
                    LeftButtonIntent: CallbackAction<LeftButtonIntent>(onInvoke: (intent) {
                      _selectedIcon = Icons.account_balance_rounded;
                      return _changeFocus(context, secondFocus!);
                    })
                  },
                  child: Focus(
                    focusNode: thirdFocus,
                    child: Container(
                      decoration: BoxDecoration(
                        border: !(thirdFocus?.hasFocus ?? false) ? null : Border.all(color: Colors.orange),
                      ),
                      child: const Icon(
                        Icons.tv,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
