import 'package:custom_form_field/src/constants.dart';
import 'package:custom_form_field/src/custom_drop_down_form_field.dart';
import 'package:flutter/material.dart';

class FormScreen2 extends StatefulWidget {
  const FormScreen2({Key? key}) : super(key: key);

  @override
  State<FormScreen2> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? customName;

  onSavePressed() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Form Field"),
        actions: [
          IconButton(onPressed: onSavePressed, icon: const Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "This is normal text"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                onChanged: (value) {},
                items: AppConstant.timeOptions
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
              ),
              FormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : "Cannot be null",
                onSaved: (value) => customName = value,
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Custom Name"),
                              onChanged: (value) => state.didChange(value),
                            ),
                          ),
                          if (state.isValid) const Icon(Icons.check),
                          if (state.hasError)
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText ?? "",
                          style: const TextStyle(color: Colors.red),
                        )
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomDropDownFormField<String>(
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : "Cannot be null",
                items: AppConstant.timeOptions
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
