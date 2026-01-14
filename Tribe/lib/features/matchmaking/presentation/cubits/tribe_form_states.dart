
import 'package:tribe/features/matchmaking/domain/entities/tribe_form.dart';

abstract class TribeFormState {}//IT'S CALLED TribeFormState BECAUSE FLUTTER HAS A BUILT IN FORMSTATE AND IT WAS CONFLICTING GRRR

class TribeFormInitial extends TribeFormState {}

class TribeFormLoading extends TribeFormState {}

class TribeFormForbidden extends TribeFormState {}//user hasn't yet edited their own profile info so no access to the form

class TribeFormUnsubmitted extends TribeFormState {//user can fill the form, hasn't submitted yet
  final TribeForm form;
  //pass FormSettings instance
  //final FormSettings formSettings;
  TribeFormUnsubmitted(this.form);
}

class TribeFormSubmitted extends TribeFormState {//user has submitted the form, is in waitlist
  final TribeForm form;
  TribeFormSubmitted(this.form);
}

class TribeFormError extends TribeFormState {//submission error
  final String message;
  TribeFormError(this.message);
}
