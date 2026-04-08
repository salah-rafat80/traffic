import '../../data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

/// Profile data fetched successfully.
class ProfileLoadSuccess extends ProfileState {
  final ProfileModel profile;
  ProfileLoadSuccess({required this.profile});
}

/// Email-change OTP sent successfully; UI should show OTP entry.
class ProfileEmailChangeRequested extends ProfileState {
  final String newEmail;
  ProfileEmailChangeRequested({required this.newEmail});
}

/// Email change confirmed successfully.
class ProfileEmailChangeConfirmed extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}
