import 'item.dart';

List<Item> generateRubbish(int maxSingleItemRubbishGrams, Function callback) {
  List<Item> rubbish = [
    Item(
      name: 'Plastic bottle screw cap',
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
      name: 'Corn flakes foil 500 g',
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
      name: 'Jar metal lid',
      weightGrams: 10,
    ),
    Item(
      name: 'Small plastic bag',
      weightGrams: 1,
    ),
  ];
  for (int i = 0; i < rubbish.length; i++) {
    final int id = i + 1;
    rubbish[i].uniqueId = id;
    rubbish[i].maxWeightGrams = maxSingleItemRubbishGrams;
    rubbish[i].refreshParentState = callback;
  }
  return rubbish;
}
