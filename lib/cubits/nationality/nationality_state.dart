part of 'nationality_cubit.dart';

class NationalityState extends Equatable {
  final Nationality nationality;

  NationalityState({required this.nationality});

  factory NationalityState.initial() {
    return NationalityState(
        nationality: Nationality(count: 1, country: [], name: ''));
  }

  @override
  List<Object> get props => [nationality];

  NationalityState copyWith({
    Nationality? nationality,
  }) {
    return NationalityState(
      nationality: nationality ?? this.nationality,
    );
  }

  @override
  bool get stringify => true;
}
