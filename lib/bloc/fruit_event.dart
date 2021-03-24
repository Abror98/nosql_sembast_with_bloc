part of 'fruit_bloc.dart';

@immutable
abstract class FruitEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadFruits extends FruitEvent {}

class AddRandomFruit extends FruitEvent {}

class UpdateWithRandomFruit extends FruitEvent {
  final Fruit updateFruit;

  UpdateWithRandomFruit(this.updateFruit);

  @override
  // TODO: implement props
  List<Object> get props => [updateFruit];
}

class DeleteEvent extends FruitEvent {
   final Fruit fruit;

   DeleteEvent(this.fruit);

   @override
  // TODO: implement props
  List<Object> get props => [fruit];
}
