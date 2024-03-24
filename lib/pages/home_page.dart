import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrud/services/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreServices firestoreServices = FirestoreServices();
  // A controller for an editable TextField
  final TextEditingController textController = TextEditingController();
  // open a dialog box to add a note
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(onPressed: (){

            firestoreServices.addNote(textController.text);



            textController.clear();
            Navigator.pop(context);
          }, child: Text("Add")),
        ]
        // actions:
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(stream: firestoreServices.getNotesStream(), builder: ((context, snapshot) {
        if(snapshot.hasData){
          List notesList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder:(context, index) {
              DocumentSnapshot document = notesList[index];
              String docID = document.id;
              // get note from each individual doc 
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String noteText = data['note'];
              return ListTile(title: Text(noteText),);
            },

          );
        }
        else {
          return const Text("No notes avaliable");
        }
      }))
    );
  }
}
