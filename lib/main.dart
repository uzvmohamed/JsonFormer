import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonformer/screens/form_screen.dart';

// Riverpod providers for state management
final jsonProvider = StateProvider<String>((ref) => '''{"fields":[]}''');

final deopDownProvider = StateProvider<String>((ref) => 'none');

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}
