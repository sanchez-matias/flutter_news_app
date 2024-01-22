import 'package:flutter_news_app/core/utils/typedef.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  ResultFuture<Type> call(Params params);
}

abstract class ParamlessUseCase<Type> {
  const ParamlessUseCase();

  ResultFuture<Type> call();
}