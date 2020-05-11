part of 'firebase.dart';

class CloudFirestore {
  final _handler = Firestore.instance;
  
  get handler => _handler;
}
