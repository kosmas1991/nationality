part of 'number_of_requests_cubit.dart';

class NumberOfRequestsState extends Equatable {
  final int requestsNumber;

  NumberOfRequestsState({required this.requestsNumber});

  factory NumberOfRequestsState.initial() {
    return NumberOfRequestsState(requestsNumber: 0);
  }

  @override
  List<Object> get props => [requestsNumber];

  NumberOfRequestsState copyWith({
    int? requestsNumber,
  }) {
    return NumberOfRequestsState(
      requestsNumber: requestsNumber ?? this.requestsNumber,
    );
  }

  @override
  bool get stringify => true;
}
