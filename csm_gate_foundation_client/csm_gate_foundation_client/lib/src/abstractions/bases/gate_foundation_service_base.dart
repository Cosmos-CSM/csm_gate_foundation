import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_gate_foundation_client/src/gate_foundation_server_options.dart';

/// Custom {abstract} class for [ServiceB] implementations.
///
///
/// Defines base behavior for [CSMGateFoundationServiceBase] implementations that are representations of requestable operations at a [ServerI] implementation.
abstract class CSMGateFoundationServiceBase extends ServiceBase {
  /// Server signature identificator.
  String get _sign => GateFoundationServerOptions.sign;

  /// Creates a new [CSMGateFoundationServiceBase] instance.
  CSMGateFoundationServiceBase(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });

  ///
  Future<IResponseController> getSecure<T extends EncodableI>(
    String endpoint,
    String authToken, {
    Headers? headers,
  }) {
    return get(
      endpoint,
      auth: '$authToken@$_sign',
      headers: headers,
    );
  }

  /// Post network call to connected server overriding [ServiceI] built-in [post] behavior overriding
  /// the [authToken] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
  ///
  /// format: authToken@solutionSign
  ///
  ///
  /// [T] type of the request body.
  ///
  ///
  /// [endpoint] endpoint request last segment.
  ///
  /// [requestBody] data object to send at the [ServerI] to handle the request.
  ///
  /// [authToken] custom {TWS} authorization token when [ServerI] controller requires it.
  ///
  /// [headers] request scope [Headers] object.
  Future<IResponseController> postSecure<T extends EncodableI>(
    String endpoint,
    T requestBody, {
    String? authToken,
    Map<String, dynamic>? headers,
  }) {
    return post(endpoint, requestBody, auth: '$authToken@$_sign');
  }

  /// Post network call to connected server overriding [ServiceI] built-in [post] behavior overriding
  /// the [authToken] token sent, sending it as a compatible custom {TWS} servers auth tokens format.
  ///
  /// format: authToken@solutionSign
  ///
  ///
  /// [T] type of the request body list.
  ///
  ///
  /// [action] endpoint request last segment.
  ///
  /// [requestBody] data object to send at the [ServerI] to handle the request.
  ///
  /// [authToken] custom {TWS} authorization token when [ServerI] controller requires it.
  ///
  /// [headers] request scope [Headers] object.
  Future<IResponseController> postListSecure<T extends EncodableI>(
    String endpoint,
    List<T> request, {
    String? authToken,
    Map<String, dynamic>? headers,
  }) {
    return postList(endpoint, request, auth: '$authToken@$_sign');
  }
}
