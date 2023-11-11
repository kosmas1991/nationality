import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nationality/models/nationality.dart';

part 'nationality_state.dart';

class NationalityCubit extends Cubit<NationalityState> {
  NationalityCubit() : super(NationalityState.initial());

  emitNewNationality(Nationality nationality) {
    print('Just got a new Nationality state      !!!');
    emit(state.copyWith(nationality: nationality));
  }
}
