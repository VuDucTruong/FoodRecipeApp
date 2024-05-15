part of 'chef_info_bloc.dart';

@immutable
sealed class ChefInfoEvent {}

class LoadChefInfoById extends ChefInfoEvent {
  String id;

  LoadChefInfoById(this.id);
}
