import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

  // Get collection reference of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');
// CREATE: add new note
Future<void> addNote(String note){
  return notes.add({
    'note':note,
    'timestamp':Timestamp.now(), 
  }
    );
}
// Read: get notes from database
//Update: update notes given note id
// Delete:delete notes given a doc id


}