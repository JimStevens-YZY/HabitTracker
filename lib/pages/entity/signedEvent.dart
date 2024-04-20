class SignedEvent {
  SignedEvent({
    required this.signedEventDate,
    required this.signedEventDesc,
    required this.signedEventName,
    required this.signedEventTime,
    required this.signedEventBg,
    required this.userId,
  });

  final String signedEventDate;
  final String signedEventDesc;
  final String signedEventName;
  final String signedEventTime;
  final String signedEventBg;
  final String userId;
}
