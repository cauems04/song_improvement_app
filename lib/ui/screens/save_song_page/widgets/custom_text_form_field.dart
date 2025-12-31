import 'package:flutter/material.dart';

class SaveSongTextFormField extends StatelessWidget {
  // Check for a unified widget for both this and SaveLink textFormField
  final String fieldName;
  final TextEditingController textEditingController;

  final String? Function(String?)? validation;

  const SaveSongTextFormField(
    this.fieldName,
    this.textEditingController, {
    super.key,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: textEditingController,
        validator: validation,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          floatingLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorStyle: TextStyle(color: Theme.of(context).colorScheme.onError),
          helperText: "",
        ),
      ),
    );
  }
}
