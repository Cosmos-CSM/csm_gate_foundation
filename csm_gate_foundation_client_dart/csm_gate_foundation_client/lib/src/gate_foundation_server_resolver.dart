import 'package:csm_client_core/csm_client_core.dart';

/// {implementation} class from a [ResponseResolverB].
///
///
/// Defines final behavior for a [GateFoundationServerResolver] wich handles [ServiceI] requests implementations from a [FoundationServer] and [FoundationServiceB], resolving
/// as a {Foundation} package scope the [ServerI] implementation responses as needed.
final class GateFoundationServerResolver<TResponseData extends IDecodable?> extends ResponseResolverBase<TResponseData> {
  /// Creates a new [GateFoundationServerResolver] instance.
  const GateFoundationServerResolver(super.controller);

  /// Resolves the [ResponseController] directly with no callback handlers.
  ///
  ///
  /// [factory] building callback for the [TResponseData] object creation in order to call [DecodableI.decode] method from [DecodableI] interface.
  @override
  TResponseData resolveDirect(TResponseData Function() factory) {
    TResponseData? result;
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<TResponseData> successFrame = SuccessFrame<TResponseData>(factory);
        successFrame.decode(data);

        result = successFrame.content;
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);
        throw TracedException(
          'FailureException: server act resulted in failure $statusCode with (${failureFrame.content.systemError})',
          StackTrace.current,
        );
      },
      (TracedException exception) {
        throw exception;
      },
    );

    if (result == null && (null is! TResponseData)) {
      throw TracedException('Unable to resolve response controller', StackTrace.current);
    }

    return result as TResponseData;
  }

  /// Resolves the [ResponseController] with the given callback handlers.
  ///
  ///
  /// [factory] building callback for the [TResponseData] object creation in order to call [DecodableI.decode] method from [DecodableI] interface.
  ///
  /// [onSuccess] callback invoked when the [ResponseController] resulted in a success.
  ///
  /// [onFailure] callback invoked when the [ResponseController] resulted in a server failure.
  ///
  /// [onException] callback invoked when the [ResponseController] resulted in a client-side exception.
  ///
  /// [onConnectionFailure] callback invoked when the [ResponseController] resulted in an exception related with connection failure.
  ///
  /// [onFinally] callback invoked after any [ResponseController] result and callback invokation.
  @override
  void resolve({
    required TResponseData Function() factory,
    required void Function(SuccessFrame<TResponseData> success) onSuccess,
    required void Function(FailureFrame failure, int status) onFailure,
    required void Function(TracedException exception) onException,
    required void Function() onConnectionFailure,
    void Function()? onFinally,
  }) {
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<TResponseData> successFrame = SuccessFrame<TResponseData>(factory);
        successFrame.decode(data);
        onSuccess(successFrame);
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);

        onFailure(failureFrame, statusCode);
      },
      (TracedException exception) {
        if (exception.toString().contains('ClientException')) {
          onConnectionFailure.call();
        } else {
          onException.call(exception);
        }
      },
    );
    onFinally?.call();
  }
}
