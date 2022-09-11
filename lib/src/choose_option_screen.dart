import 'package:flutter/material.dart';

class ChooseOptionScreen<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? selectedValue;

  const ChooseOptionScreen({
    Key? key,
    required this.items,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Choose an option")),
        body: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  height: 1,
                ),
            itemBuilder: (context, index) {
              var currentItem = items[index];
              return InkWell(
                  onTap: () => Navigator.pop(context, currentItem.value),
                  child: Row(
                    children: [
                      Expanded(child: currentItem),
                      if (selectedValue == currentItem.value)
                        const Icon(Icons.check)
                    ],
                  ));
            }));
  }
}
