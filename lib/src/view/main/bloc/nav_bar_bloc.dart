import '/src/data/library/library.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarState()) {
    on<NavbarStartEvent>(navbarStartEvent);
    on<NavbarChangeEvent>(navbarChangeEvent);
  }

  FutureOr navbarStartEvent(NavbarStartEvent event, Emitter<NavBarState> emit) {
    emit(NavBarState());
  }

  FutureOr navbarChangeEvent(
      NavbarChangeEvent event, Emitter<NavBarState> emit) {
    emit(NavBarState(id: event.id));
  }
}
