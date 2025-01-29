import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonformer/main.dart';
import 'package:jsonformer/models/field_model.dart';

class FormPage extends ConsumerWidget {
  final TextEditingController jsonController = TextEditingController(text: '''[
{ "field_name": "f1", "widget": "dropdown", "valid_values": ["A", "B"] },
 { "field_name": "f2", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f3", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f4", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f5", "widget": "textfield", "visible": "f1=='B'" },
 { "field_name": "f6", "widget": "textfield", "visible": "f1=='B'" }
 ]
''');

  FormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonInput = ref.watch(jsonProvider);
    List<Field>? fields = [];
    try {
      fields = Fields.fromRawJson(jsonInput).fields;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('please enter a valid json schema'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.info_outline,
                      color: Colors.red, size: 30),
                ),
              );
            });
        // Add Your Code here.
      });
    }
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Text(
            'Json Form Builder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Spacer(),
          Image.asset('assets/icon.png', height: 30, width: 30),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'JSON Editor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter JSON to define the form',
                ),
                controller: jsonController,
                maxLines: 50,
                minLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  try {
                    ref.read(jsonProvider.notifier).state =
                        '''{"fields": ${jsonController.text}}''';
                  } catch (e) {
                    showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title:
                                const Text('please enter a valid json schema'),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.info_outline,
                                  color: Colors.red, size: 30),
                            ),
                          );
                        });
                  }
                },
                child: const Text('Build Form'),
              ),
              const SizedBox(height: 6),
              if (fields != null)
                ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: fields.map((i) {
                      var value = ref.watch(deopDownProvider);
                      if (i.widget == 'dropdown' && i.visible == null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'choose type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: i.validValues!
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              ref
                                  .read(deopDownProvider.notifier)
                                  .update((state) => state = v ?? '');
                            },
                          ),
                        );
                      } else if (i.visible!
                                  .split('==')[1]
                                  .replaceAll("'", '') ==
                              value &&
                          i.widget == 'textfield') {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: i.fieldName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: TextEditingController(),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
