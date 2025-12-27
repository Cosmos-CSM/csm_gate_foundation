import 'package:csm_client_core/csm_client_core.dart';

/// Represents a server session data.
final class SessionData implements DecodableI, EncodableI {
  /// Privileges wildcard, means can access everything.
  bool wildcard = false;

  /// Services auth token.
  String token = '';

  /// [token] timemark expiration
  DateTime expiration = DateTime(0);

  /// Generates a new [SessionData] instance.
  SessionData();

  @override
  void decode(DataMap encode) {
    token = encode.get('token');
    expiration = encode.get('expiration');
    wildcard = encode.get('wildcard', false);
  }

  @override
  DataMap encode() {
    return <String, Object?>{
      'token': token,
      'wildcard': wildcard,
      'expiration': expiration.toIso8601String(),
    };
  }
}
