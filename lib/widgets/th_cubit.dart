import 'package:flutter_bloc/flutter_bloc.dart';

class ThCubit<T> extends Cubit<T> {
  ThCubit(super.initialState);

  @override
  void emit(T state) {
    if (isClosed) {
      return;
    }

    super.emit(state);
  }
}
