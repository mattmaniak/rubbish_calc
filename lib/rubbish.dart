import 'item.dart';

List<Item> generateRubbish(int maxRubbishGrams, Function callback) {
  List<Item> rubbish = [
    Item(
      uniqueId: 1,
      name: 'Plastic bottle cap',
      weightGrams: 1,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    // https://www.quora.com/How-much-does-a-single-metal-bottle-cap-weigh-from-a-beer-or-soda-bottle
    Item(
      uniqueId: 2,
      name: 'Metal bottle cap',
      weightGrams: 2,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    // https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
    Item(
      uniqueId: 3,
      name: 'PET Bottle 0.5 L',
      weightGrams: 10,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    Item(
      uniqueId: 4,
      name: 'PET Bottle 1.0 L',
      weightGrams: 20,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    // https://www.quora.com/How-much-does-a-330ml-can-of-soda-weigh-in-grams
    Item(
      uniqueId: 5,
      name: 'Aluminium soda can 0.33 L',
      weightGrams: 30,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    Item(
      uniqueId: 6,
      name: 'PET Bottle 1.5 L',
      weightGrams: 30,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    Item(
      uniqueId: 7,
      name: 'Juicebox 1.5 L',
      weightGrams: 45,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    Item(
      uniqueId: 8,
      name: 'Juicebox 2 L',
      weightGrams: 60,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    // https://en.m.wikipedia.org/wiki/Wine_bottle#Environmental_impact
    Item(
      uniqueId: 9,
      name: 'Glass wine bottle 0.75 L',
      weightGrams: 500,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
    Item(
      uniqueId: 10,
      name: 'Juicebox 1.0 L',
      weightGrams: 30,
      maxWeightGrams: maxRubbishGrams,
      refreshParentState: callback,
    ),
  ];
  rubbish.sort((a, b) => a.weightGrams.compareTo(b.weightGrams));

  return rubbish;
}
