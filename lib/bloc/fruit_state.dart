part of 'fruit_bloc.dart';

@immutable
abstract class FruitState extends Equatable{}

class FruitLoadingState extends FruitState {

  @override
  List<Object> get props => [];
}

class FruitLoadedState extends FruitState {
  final List<Fruit> fruits;

  FruitLoadedState(this.fruits);

  @override
  // TODO: implement props
  List<Object> get props => [fruits];
}
