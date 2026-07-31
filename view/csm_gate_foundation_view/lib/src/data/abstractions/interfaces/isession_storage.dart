import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';

/// Represents a view solution session persistance and management storage object, provides several
/// operations to handle, communicate and interact with user authentication information contexts.
abstract interface class ISessionStorage {
  final String token;

  final bool isLive;

  /// Stores the given [sessionData] into the current [SessionStorage] handling context and preservers it for future requests.
  void store(SessionData sessionData);

  /// Clears all the preserve session from the storage.
  void clear();

  /// Creates a new instance.
  const ISessionStorage(this.token, this.isLive);
}
