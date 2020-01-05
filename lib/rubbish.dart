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
      name: 'PET bottle 0.5 L',
      weightGrams: 10,
    ),
    Item(
      name: 'PET bottle 1.0 L',
      weightGrams: 20,
    ),
    // https://www.quora.com/How-much-does-a-330ml-can-of-soda-weigh-in-grams
    Item(
      name: 'Aluminium soda can 0.33 L',
      weightGrams: 30,
    ),
    Item(
      name: 'PET bottle 1.5 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Juicebox 1.5 L',
      weightGrams: 45,
    ),
    Item(
      name: 'Juicebox 2.0 L',
      weightGrams: 60,
    ),
    // https://en.m.wikipedia.org/wiki/Wine_bottle#Environmental_impact
    Item(
      name: 'Glass bottle 0.75 L',
      weightGrams: 500,
    ),
    Item(
      name: 'Juicebox 1.0 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Candy Bar foil',
      weightGrams: 1,
    ),
    // Item(
    //   name: 'Neue item',
    //   weightGrams: 8,
    // ),
  ];
  for (int i = 0; i < rubbish.length; i++) {
    final int id = i + 1;
    rubbish[i].uniqueId = id;
    rubbish[i].maxWeightGrams = maxRubbishGrams;
    rubbish[i].refreshParentState = callback;
  }
  return rubbish;
}
