import 'dart:convert';
import 'dart:typed_data';

import 'package:csm_client_core/csm_client_core.dart';

/// Represents an { Auth } operation input data.
final class AuthInput implements EncodableI {
  /// Solution signature.
  String sign = '';

  /// User account identity.
  String username = '';

  /// User account password sign.
  Uint8List password = Uint8List(0);

  /// Generates a new [AuthInput] object.
  AuthInput();

  ///
  AuthInput.a(
    this.sign,
    this.username,
    this.password,
  );

  @override
  DataMap encode() {
    return <String, dynamic>{
      'sign': sign,
      'username': username,
      'password': base64Encode(password),
    };
  }
}
