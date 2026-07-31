import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:localstorage/localstorage.dart';

/// Represents an storage data handler for session data.
final class SessionStorage implements ISessionStorage {
  /// Gets the session data storage location key based on the solution signature for [token].
  String get _tokenKey => "${signature}_sst";

  /// Gets the session data storage location key based on the solution signature for [expiration].
  String get _expKey => "${signature}_sse";

  /// { View } module solution signature for storage data identification.
  final String signature;

  @override
  String get token {
    return _token ?? '';
  }

  String? _token;
  DateTime? _expiration;

  @override
  bool get isLive {
    return _validateExpiration(_expiration);
  }

  /// Creates a new instance.
  SessionStorage(
    this.signature,
  ) {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      String? tokenValue = localStorage.getItem(_tokenKey);
      String? expirationValue = localStorage.getItem(_expKey);

      if (tokenValue == null || expirationValue == null) {
        return;
      }

      _token = tokenValue;
      _expiration = DateTime.parse(expirationValue).toLocal();
    } catch (x) {
      throw 'Before creating a new SessionStorage instance you need to wait for initLocalStorage() method $x';
    }
  }

  @override
  void store(SessionData sessionData) {
    _token = sessionData.token;
    _expiration = sessionData.expiration;

    if (_token == null || _expiration == null) {
      throw 'Can\'t save [serverSession] if the token or expiration is null';
    }

    localStorage.setItem(_tokenKey, _token!);
    localStorage.setItem(_expKey, _expiration!.toIso8601String());
  }

  @override
  void clear() {
    localStorage.removeItem(_tokenKey);
    localStorage.removeItem(_expKey);
    _token = null;
    _expiration = null;
  }

  /// Validates if the given [expiration] is into the time threshold and it's considered valid.
  static bool _validateExpiration(DateTime? expiration) {
    if (expiration == null) return false;

    DateTime now = DateTime.now();
    DateTime expLocal = expiration.toLocal();

    return now.isBefore(expLocal);
  }
}
