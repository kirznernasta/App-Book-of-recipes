import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_main_page_state.dart';

class AdminMainPageCubit extends Cubit<AdminMainPageState> {
  AdminMainPageCubit() : super(AdminMainPageState());

  void changeSelectedIndex(int index) => emit(
        state.copyWith(
          changedSelectedIndex: index,
        ),
      );
}
