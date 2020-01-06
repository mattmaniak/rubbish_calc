import 'item.dart';

List<Item> generateRubbish(int maxRubbishGrams, Function callback) {
  List<Item> rubbish = [
    Item(
      name: 'Plastic bottle cap',
      weightGrams: 1,
    ),
    // https://www.quora.com/How-much-does-a-single-metal-bottle-cap-weigh-from-a-beer-or-soda-bottle
    Item(
      name: 'Metal bottle cap',
      weightGrams: 2,
    ),
    // https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
    Item(
      name: 'Plastic bottle 0.5 L',
      weightGrams: 10,
    ),
    Item(
      name: 'Plastic bottle 1.0 L',
      weightGrams: 20,
    ),
    // http://www.chymist.com/Aluminum%20can.pdf
    Item(
      name: 'Aluminium can 0.33 L',
      weightGrams: 13,
    ),
    Item(
      name: 'Plastic bottle 1.5 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Carton juicebox 1.5 L',
      weightGrams: 45,
    ),
    Item(
      name: 'Carton juicebox 2.0 L',
      weightGrams: 60,
    ),
    // https://en.m.wikipedia.org/wiki/Wine_bottle#Environmental_impact
    Item(
      name: 'Glass bottle 0.75 L',
      weightGrams: 500,
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
  ];
  for (int i = 0; i < rubbish.length; i++) {
    final int id = i + 1;
    rubbish[i].uniqueId = id;
    rubbish[i].maxWeightGrams = maxRubbishGrams;
    rubbish[i].refreshParentState = callback;
  }
  return rubbish;
}
