import 'package:flutter/material.dart';
import 'package:flutter_deshh/components/app_button.dart';
import 'package:flutter_deshh/components/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPage extends StatefulWidget {
  final String title;
  final String description;
  final int id;
  const EditPage(
      {super.key,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Edit Notes",
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
                    await Supabase.instance.client.from('notes').update({
                      'title': titleController.text,
                      'description': descriptionController.text
                    }).match({'id': widget.id});
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
