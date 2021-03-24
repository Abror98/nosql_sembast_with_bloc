import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nosql_sembast/data/fruit.dart';
import 'package:nosql_sembast/data/fruit_dao.dart';

part 'fruit_event.dart';
part 'fruit_state.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  FruitDao _fruitDao = FruitDao();

  FruitBloc() : super(FruitLoadingState());


  @override
  Stream<FruitState> mapEventToState(
      FruitEvent event,
      ) async* {
    if (event is LoadFruits) {
      yield FruitLoadingState();
      yield* _reloadFruits();
    } else if (event is AddRandomFruit) {
      await _fruitDao.insert(RandomFruitGenerator.getRandomFruit());
      yield* _reloadFruits();
    } else if (event is UpdateWithRandomFruit) {
      final newFruit = RandomFruitGenerator.getRandomFruit();
      // Keeping the ID of the Fruit the same
      newFruit.id = event.updateFruit.id;
      await _fruitDao.update(newFruit);
      yield* _reloadFruits();
    } else if (event is DeleteEvent) {
      await _fruitDao.delete(event.fruit);
      yield* _reloadFruits();
    }
  }

  Stream<FruitState> _reloadFruits() async* {
    final fruits = await _fruitDao.getAllSortedByName();
    yield FruitLoadedState(fruits);
  }
}

class RandomFruitGenerator {
  static final _fruits = [
    Fruit(name: 'Banana', isSweet: true),
    Fruit(name: 'Strawberry', isSweet: true),
    Fruit(name: 'Kiwi', isSweet: false),
    Fruit(name: 'Apple', isSweet: true),
    Fruit(name: 'Pear', isSweet: true),
    Fruit(name: 'Lemon', isSweet: false),
  ];

  static Fruit getRandomFruit() {
    return _fruits[Random().nextInt(_fruits.length)];
  }
}