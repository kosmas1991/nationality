import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nationality/cubits/nationality/nationality_cubit.dart';

part 'number_of_requests_state.dart';

class NumberOfRequestsCubit extends Cubit<NumberOfRequestsState> {
  late final StreamSubscription streamSubscription;
  final NationalityCubit nationalityCubit;
  NumberOfRequestsCubit({required this.nationalityCubit})
      : super(NumberOfRequestsState.initial()) {
    streamSubscription =
        nationalityCubit.stream.listen((NationalityState nationalityState) {
      //emit(state.copyWith(requestsNumber: state.requestsNumber + 1));
      addOne();
    });
  }

  emitNewNumber(int newNumber) {
    emit(state.copyWith(requestsNumber: newNumber));
  }

  addOne() {
    emit(state.copyWith(requestsNumber: state.requestsNumber + 1));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
