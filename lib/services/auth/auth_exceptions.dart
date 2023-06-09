//login view exceptions
class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}

//register view exceptions
class WeakPasswordAuthException implements Exception {}
class EmaiAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception{}

//generic exception
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}