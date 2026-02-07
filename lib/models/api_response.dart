// lib/models/api_response.dart

/// Sealed class to represent the state of an API call.
/// It can be in one of three states: Loading, Success, or Error.
abstract class ApiResponse<T> {
  const ApiResponse();
}

/// Represents the loading state of an API call.
class ApiLoading<T> extends ApiResponse<T> {
  const ApiLoading();
}

/// Represents a successful API call with the retrieved data.
class ApiSuccess<T> extends ApiResponse<T> {
  final T data;
  const ApiSuccess(this.data);
}

/// Represents an error that occurred during an API call.
class ApiError<T> extends ApiResponse<T> {
  final String message;
  const ApiError(this.message);
}
