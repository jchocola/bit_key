import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// EVENT
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// STATE
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocInitial extends AuthBlocState {}

class AuthBlocLoading extends AuthBlocState {}

class AuthBlocSuccess extends AuthBlocState {
  final String? salt;
  final String? controlSumString;
  final String? MASTER_KEY;
  AuthBlocSuccess({this.salt, this.controlSumString, this.MASTER_KEY});

  @override
  List<Object?> get props => [salt, controlSumString, MASTER_KEY];
}

class AuthBlocFailure extends AuthBlocState {}

//BLOC
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthBlocInitial()) {}
}
