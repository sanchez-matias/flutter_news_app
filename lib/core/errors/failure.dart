import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String statusCode;
  final String message;

  const Failure({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.statusCode, required super.message});
}
