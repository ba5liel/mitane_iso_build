import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserAdminLoading extends UserState {}

class UserAdminOperationSuccess extends UserState {
  final Iterable<dynamic> users;
  final Iterable<dynamic> roles;

  UserAdminOperationSuccess([this.users = const [], this.roles = const []]);

  @override
  List<Object> get props => [users, roles];
}

class UserAdminOperationFailure extends UserState {}
