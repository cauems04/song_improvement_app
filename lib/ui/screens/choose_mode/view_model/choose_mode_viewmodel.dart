import 'package:flutter/material.dart';

class ChooseModeViewmodel {
  final ValueNotifier isPlaySelected = ValueNotifier<bool>(true);
  final ValueNotifier rememberChoice = ValueNotifier<bool>(false);

  ChooseModeViewmodel();

  void selectPlayOption() {
    if (isPlaySelected.value == false) {
      isPlaySelected.value = !isPlaySelected.value;
    }
  }

  void unselectPlayOption() {
    if (isPlaySelected.value == true) {
      isPlaySelected.value = !isPlaySelected.value;
    }
  }

  void toggleRememberChoice() {
    rememberChoice.value = !rememberChoice.value;
  }

  void onConfirmPressed() async {}
}
