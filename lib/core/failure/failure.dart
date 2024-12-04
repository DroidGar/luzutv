abstract class Failure {
  final String message;

  Failure(this.message);
}

class UnhandledFailure extends Failure {
  UnhandledFailure({String message = 'Unhandled Failure'}) : super(message);
}
