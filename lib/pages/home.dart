import 'package:flutter/material.dart';
import 'package:flutter_deshh/components/app_button.dart';
import 'package:flutter_deshh/components/card_item.dart';
import 'package:flutter_deshh/components/input_field.dart';
import 'package:flutter_deshh/pages/login.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notesList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    dynamic res = await Supabase.instance.client
        .from('notes')
        .select<List<Map<String, dynamic>>>();
    setState(() {
      notesList = res;
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: Button(
                    label: 'Logout',
                    backgroundColor: Colors.redAccent,
                    onPressed: (() {
                      final box = GetStorage();
                      box.remove("username");
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => const LoginPage()),
                          (route) => false);
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Notes App",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                InputField(label: "Title", inputController: titleController),
                const SizedBox(height: 20),
                InputField(
                    label: "Description",
                    inputController: descriptionController),
                const SizedBox(height: 30),
                Button(
                  label: "Simpan",
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    await Supabase.instance.client.from('notes').insert({
                      'title': titleController.text,
                      'description': descriptionController.text
                    });
                    fetchData();
                    titleController.text = '';
                    descriptionController.text = '';
                  },
                ),
                // Notes List
                const SizedBox(height: 40),
                Wrap(
                    children: notesList
                        .map((note) => NotesCard(
                              id: note['id'],
                              title: note['title'],
                              description: note['description'],
                              fetchData: () {
                                fetchData();
                              },
                            ))
                        .toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
