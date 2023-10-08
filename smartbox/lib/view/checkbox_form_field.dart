import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      { super.key,
        FormFieldSetter<bool>? onSaved,
        FormFieldValidator<bool>? validator,
        bool initialValue = false,
        bool autovalidate = false,
        required Function(dynamic value) onChanged})
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<bool> state) {
       return InputDecorator(
         decoration: InputDecoration(
             labelText: 'Test',
             constraints: BoxConstraints(maxHeight: 1.0, maxWidth: 1.0)
         ),
         child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: state.hasError,
              value: state.value,
              onChanged: (value ) { state.didChange(value); onChanged(value); },
              subtitle: state.hasError
                  ? Builder(
                builder: (BuildContext context) => Text(
                  state.errorText ?? "",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error),
                ),
              )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
         ),
       );
      });
}
