// login expections
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}

// register expections
class EmailAlreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}
class WeakPasswordAuthException implements Exception{}

// register expections
class GenericAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}

