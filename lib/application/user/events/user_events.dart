import 'package:equatable/equatable.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserAdminLoad extends UserEvent {
  const UserAdminLoad();

  @override
  List<Object> get props => [];
}

class UserAdminCreate extends UserEvent {
  final User user;

  const UserAdminCreate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Created {User: $user}';
}

class UserAdminUpdate extends UserEvent {
  final User user;

  const UserAdminUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Updated {User: $user}';
}

class UserAdminDelete extends UserEvent {
  final String id;

  const UserAdminDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'User Deleted {User Id: $id}';
}

class UserAdminDisplay extends UserEvent {
  final String role;

  const UserAdminDisplay(this.role);

  @override
  List<Object> get props => [role];

  @override
  toString() => 'User Deleted {User Id: $role}';
}
