class SignedEvent {
  SignedEvent({
    required this.signedEventDate,
    required this.signedEventDesc,
    required this.signedEventName,
    required this.signedEventTime,
    required this.userId,
  });

  final String signedEventDate;
  final String signedEventDesc;
  final String signedEventName;
  final String signedEventTime;
  final String userId;
}
