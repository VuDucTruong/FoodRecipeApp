part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class EditProfileInitialLoadEvent extends EditProfileEvent {

}

class EditProfileSubmitEvent extends EditProfileEvent {
  final ProfileInformation profileInformation;
  MultipartFile? avatar;

  EditProfileSubmitEvent(this.profileInformation, this.avatar);
}


class EditProfileDeleteEvent extends EditProfileEvent {

  EditProfileDeleteEvent();
}