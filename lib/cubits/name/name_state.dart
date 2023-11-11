part of 'name_cubit.dart';

class NameState extends Equatable {
  final String name;
  NameState({
    required this.name,
  });

  factory NameState.initial() {
    return NameState(name: '');
  }

  @override
  List<Object> get props => [name];

  NameState copyWith({
    String? name,
  }) {
    return NameState(
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;
}
