import 'package:flutter/material.dart';
import 'package:flutter_deshh/pages/login.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://skjirkdqmypizzcqnqvw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNramlya2RxbXlwaXp6Y3FucXZ3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTk1NTY2NCwiZXhwIjoyMDE1NTMxNjY0fQ.bPpzXU2boKr13zX1vYHje6lkc6tzqQHtHK9ONH33GX0',
  );
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: LoginPage()),
    );
  }
}
