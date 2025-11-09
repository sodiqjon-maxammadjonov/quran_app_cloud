part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarEvent {}

final class NavbarStartEvent extends NavBarEvent {}

final class NavbarChangeEvent extends NavBarEvent {
  final int id;

  NavbarChangeEvent({required this.id});

  List<Object?> get props => [id];
}
