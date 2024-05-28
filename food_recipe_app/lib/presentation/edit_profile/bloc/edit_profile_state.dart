part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

//---------------------------------------------------------
class EditProfileSuccess extends EditProfileState {
  final ProfileInformation profileInformation;

  EditProfileSuccess(this.profileInformation);
}

class EditProfileInitialLoadSuccess extends EditProfileSuccess {
  EditProfileInitialLoadSuccess(super.profileInformation);
}

class EditProfileSubmitSuccess extends EditProfileSuccess {
  EditProfileSubmitSuccess(super.profileInformation);
}

class EditProfileDeleteSuccess extends EditProfileState{}

//---------------------------------------------------------
class EditProfileFailed extends EditProfileState {
  final Failure failure;

  EditProfileFailed(this.failure);
}

class EditProfileInitialLoadFailed extends EditProfileFailed {

  EditProfileInitialLoadFailed(super.failure);
}

class EditProfileSubmitFailed extends EditProfileFailed {
  EditProfileSubmitFailed(super.failure);
}


class EditProfileDeleteFailed extends EditProfileFailed {
  EditProfileDeleteFailed(Failure failure) : super(failure);
}

