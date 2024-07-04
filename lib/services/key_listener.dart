import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyListener extends StatelessWidget {
  const KeyListener({
    super.key,
    this.enabled = true,
    this.onSpacePressed,
    this.onBackspacePressed,
    this.onCtrlBackspacePressed,
    this.onCharacterInput,
    required this.focusNode,
    required this.child,
  });

  final FocusNode focusNode;
  final VoidCallback? onSpacePressed;
  final VoidCallback? onBackspacePressed;
  final VoidCallback? onCtrlBackspacePressed;
  final void Function(String character)? onCharacterInput;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (enabled) {
          bool isCtrlPressed =
              Theme.of(context).platform == TargetPlatform.macOS
                  ? HardwareKeyboard.instance.isAltPressed
                  : HardwareKeyboard.instance.isControlPressed;
          if (event is KeyUpEvent) {
            return;
          }

          if (isCtrlPressed &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            onCtrlBackspacePressed?.call();
          }


          if (HardwareKeyboard.instance.isAltPressed ||
              HardwareKeyboard.instance.isControlPressed ||
              HardwareKeyboard.instance.isMetaPressed) {
            return;
          }

          if (event.logicalKey == LogicalKeyboardKey.space) {
            onSpacePressed?.call();
          } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
            onBackspacePressed?.call();
          } else if (event.character != null) {
            onCharacterInput?.call(event.character!);
          }

          focusNode.requestFocus();
        }
      },
      child: child,
    );
  }
}
