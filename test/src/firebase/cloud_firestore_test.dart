import 'package:flutter_test/flutter_test.dart';

import '../../utils/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/firebase/firebase.dart' as firebase;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Firestore', () {
    final firestore = firebase.CloudFirestore();
    commonTests.testNewObject(firestore, firebase.CloudFirestore);
  });
}
