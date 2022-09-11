import 'package:custom_form_field/src/choose_option_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDownFormField<T> extends FormField<T> {
  CustomDropDownFormField({
    Key? key,
    required List<DropdownMenuItem<T>> items,
    FormFieldValidator<T>? validator,
    Widget? hintText,
    Function(T?)? onSaved,
  }) : super(
          key: key,
          validator: validator,
          onSaved: onSaved,
          builder: (state) {
            var selectedItem =
                items.where((element) => element.value == state.value).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    var result = await Navigator.push(
                        state.context,
                        CupertinoPageRoute(
                            builder: (_) => ChooseOptionScreen(
                                items: items, selectedValue: state.value)));
                    if (result != null) state.didChange(result);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: selectedItem.isNotEmpty
                                ? selectedItem[0]
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: hintText ??
                                        const Text("Choose an option"),
                                  )),
                        const Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Text(
                    state.errorText ?? "Invalid field",
                    style: const TextStyle(color: Colors.red),
                  )
              ],
            );
          },
        );
}
