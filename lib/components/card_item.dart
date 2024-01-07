import 'package:flutter/material.dart';
import 'package:flutter_deshh/components/app_button.dart';
import 'package:flutter_deshh/pages/edit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesCard extends StatelessWidget {
  final String title;
  final String description;
  final int id;
  final void Function() fetchData;
  const NotesCard(
      {super.key,
      required this.title,
      required this.description,
      required this.id,
      required this.fetchData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(description),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    child: Button(
                      label: "Edit",
                      backgroundColor: Colors.yellow,
                      btnHeight: 25,
                      btnFontSize: 12,
                      onPressed: () async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (ctx) => EditPage(
                                    title: title,
                                    description: description,
                                    id: id)))
                            .then((value) => {fetchData()});
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.red),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                      ),
                      tooltip: 'Delete',
                      splashRadius: 20,
                      alignment: Alignment.center,
                      color: Colors.white,
                      onPressed: () async {
                        await Supabase.instance.client
                            .from('notes')
                            .delete()
                            .match({'id': id});
                        fetchData();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
