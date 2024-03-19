part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileEvent {}

class InputText extends CreateProfileEvent {
  String? textInput;
  String? Function(String? value) validator;

  InputText({this.textInput, required this.validator});
}
