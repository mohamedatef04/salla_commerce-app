import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());
  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(NavbarChanged());
  }
}
