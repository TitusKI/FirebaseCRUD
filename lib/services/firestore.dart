import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

  // Get collection reference of notes
  // FirebaseFirestore is the entry point for accessing Firestore functionality in a flutter app
  // FirebaseFirestore.instance returns an instance of the FirebaseFirestore class for making interact with firestore
  // .collection("notes") either retirve the existing 'notes' collection if already exist//
  //or create a new one if dooesn't exist
  // Collections are container for documents and store individual piece of data

  // CollectionRefernce a class that represents a refernce to a specific collection in firestore
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
Stream<QuerySnapshot> getNotesStream(){

  //Stream<QuerySnapshot> it contains the result of a query it can contain zero or more 
  //.orderBy('timestamp', descending: true) used to order documents in the collection based on the value of the tiimestamp in descending order
  // .snapshot() creates a stream of snapshot that emits events whenever the data in the Firestore collections changes.
  final notesStream = notes.orderBy('timestamp', descending: true).snapshots();

  return notesStream;
}
//Update: update notes given note id
// Delete:delete notes given a doc id


}