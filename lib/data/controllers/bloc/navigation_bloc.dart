import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<UpdateNavigator>((event, emit) {
      emit(NavigateToHomeSuccess());
      print("emitting");
    });
  }
}
