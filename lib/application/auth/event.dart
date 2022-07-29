part of 'bloc.dart';

abstract class TestEvent {}

class InitEvent extends TestEvent {}

class UpdateAccountEvent extends TestEvent {
  String account;
  UpdateAccountEvent({required this.account});
}

class UpdateTokenEvent extends TestEvent {
  String token;
  UpdateTokenEvent({required this.token});
}

class UpdateEmailEvent extends TestEvent {
  String email;
  UpdateEmailEvent({required this.email});
}

class UpdateRankEvent extends TestEvent {
  int rank;
  UpdateRankEvent({required this.rank});
}

class LogoutEvent extends TestEvent {}