import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ayah_event.dart';
part 'ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  AyahBloc() : super(AyahInitial()) {
    on<AyahEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
