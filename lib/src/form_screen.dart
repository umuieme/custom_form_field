import 'package:custom_form_field/src/constants.dart';
import 'package:custom_form_field/src/custom_drop_down_form_field.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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
              // normal textfield
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "This is normal text"),
                validator: (value) => value?.trim().isNotEmpty ?? false
                    ? null
                    : "This field is required",
              ),
              const SizedBox(height: 10),
              // normal dropdown field
              DropdownButtonFormField(
                onChanged: (value) {},
                validator: (value) =>
                    value != null ? null : "Please select an option ",
                items: AppConstant.timeOptions
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
              ),
              // custom textfield in same codebase
              FormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value?.trim().isNotEmpty ?? false)
                    ? null
                    : "This is a required field",
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
              const SizedBox(height: 16),
              // custom textfield in seperate file
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
