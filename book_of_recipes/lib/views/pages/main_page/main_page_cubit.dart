import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageState());

  void changeSelectedIndex(int index) => emit(
        state.copyWith(
          changedSelectedIndex: index,
        ),
      );
}
