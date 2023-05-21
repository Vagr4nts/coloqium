abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}
class DecrementCounterEvent extends CounterEvent {}

class AddToCounterEvent extends CounterEvent {
  final int number;
  AddToCounterEvent({required this.number});
} 