part of 'nav_bar_bloc.dart';

@immutable
class NavBarState{
  final int id;

  const NavBarState({this.id = 0});

  List<Object?> get props => [id];
}

