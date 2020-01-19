import 'item.dart';

List<Item> generateRubbish(Function callback) {
  List<Item> rubbish = [
    Item(
      name: 'Plastic bottle cap',
      weightGrams: 1,
    ),
    Item(
      name: 'Plastic bottle 0.5 L',
      weightGrams: 15,
    ),
    Item(
      name: 'Plastic bottle 1.5 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Carton juicebox 1.5 L',
      weightGrams: 48,
    ),
    Item(
      name: 'Carton juicebox 2.0 L',
      weightGrams: 60,
    ),
    Item(
      name: 'Carton juicebox 1.0 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Candy Bar foil',
      weightGrams: 1,
    ),
    Item(
      name: '500 g corn flakes foil',
      weightGrams: 10,
    ),
    Item(
      name: 'Steel tin can 0.425 L',
      weightGrams: 55,
    ),
    Item(
      name: 'Aluminium can 0.5 L',
      weightGrams: 17,
    ),
    Item(
      name: 'Steel jar lid',
      weightGrams: 10,
    ),
    Item(
      name: 'Small plastic bag',
      weightGrams: 1,
    ),
    Item(
      name: 'Plastic bottle 5.0 L',
      weightGrams: 70,
    ),
  ];
  for (int i = 0; i < rubbish.length; i++) {
    final int id = i + 1;
    rubbish[i].id = id;
    rubbish[i].refreshParentState = callback;
  }
  return rubbish;
}
