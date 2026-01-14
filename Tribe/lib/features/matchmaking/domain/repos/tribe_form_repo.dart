import 'package:tribe/features/matchmaking/domain/entities/tribe_form.dart';

abstract class TribeFormRepo {
  Future<void> submitForm(TribeForm form);
  Future<TribeForm?> unsubmitForm();//user can, while on waitlist, unsubmit form to change choices and resubmit
}
