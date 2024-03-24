import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrud/services/firestore.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FirestoreServices interact with Firestore (which is NOSql cloud database provide by Firebase) it contains many functionality which is related to database
  final FirestoreServices firestoreServices = FirestoreServices();
  // A controller for an editable TextField
  final TextEditingController textController = TextEditingController();
  // open a dialog box to add a note
  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                if(docId == null){
                  firestoreServices.addNote(textController.text);
                }
                else{
                  firestoreServices.updateNote(docId, textController.text);
                }

                  textController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.blueAccent),
                )),
          ]
          // actions:
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Center(child: Text("My Notes")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: openNoteBox,
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
            stream: firestoreServices.getNotesStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                // extract list of document from snapshot
                // docs property contains list of QueryDocumentSnapshot' objects represents the firestore collections
                List notesList = snapshot.data!.docs;
                return ListView.builder(
                  // no of documents in the Firestore collections
                  itemCount: notesList.length,
                  // specifies a callback function that is called for each item in the list
                  itemBuilder: (context, index) {
                    // Retrives the DocumentSnapshot object representing the document at the current indes
                    DocumentSnapshot document = notesList[index];
                    // extract the id of the current document
                    String docID = document.id;

                    // get note from each individual doc
                    // retrives the data stored in the current document as  Map<String, dynamic>
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    // we only need the note text value of the key note
                    String noteText = data['note'];
                    return Column(
                      children: [
                        ListTile(
                            title: Text(noteText),
                            trailing: IconButton(
                              onPressed: () => openNoteBox(docId:docID ),
                              icon: const Icon(Icons.settings),
                            )),
                        const Divider(
                          height: 8.0,
                        )
                      ],
                    );
                  },
                );
              } else {
                return const Text("No notes avaliable");
              }
            })));
  }
}
