class CustomException {
  final String errorMessage;
  CustomException({required this.errorMessage});

  @override
  String toString() => errorMessage;
}
