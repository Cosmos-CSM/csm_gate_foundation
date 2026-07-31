/// Provides constants access for application messages.
final class GateFoundationViewMessageConstants {
  /// Error message displayed when there has been a state management error.
  static const String stateManagementError = 'Unexpected state management error, contact support.';

  /// Error message displayed when some input was empty.
  static const String emptyInputError = 'Cannot be empty.';

  /// Error message displayed when { View } application got connection errors with some comm client.
  static const String connectionError = 'Unable to connect with server, contact administration support.';

  /// Error message when { View } application client comm got a server error.
  static const String unknownServerException = '(critical) Server error, contact administration support.';
}
