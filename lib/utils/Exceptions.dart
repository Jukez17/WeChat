abstract class WechatException implements Exception{
    String errorMessage();
}
class UserNotFoundException extends WechatException{
  @override
  String errorMessage() => 'No user found for provided uid/username';

}
class UsernameMappingUndefinedException extends WechatException{
  @override
  String errorMessage() =>'User not found';

}
class ContactAlreadyExistsException extends WechatException{
  @override
  String errorMessage() => 'Contact already exists!';
}