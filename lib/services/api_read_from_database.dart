import 'package:firebase_database/firebase_database.dart';

Future<String> getApiKey() async {
  final reference = FirebaseDatabase.instance.ref().child('api');
  final event = await reference.once();
  return event.snapshot.value as String;
}
