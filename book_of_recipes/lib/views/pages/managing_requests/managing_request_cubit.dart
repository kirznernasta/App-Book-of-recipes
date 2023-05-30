import 'package:flutter_bloc/flutter_bloc.dart';

part 'managing_request_state.dart';

class ManagingRequestCubit extends Cubit<ManagingRequestState> {
  ManagingRequestCubit() : super(ManagingRequestState());
}
