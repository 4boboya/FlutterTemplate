import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<TestEvent, AuthState> {
  AuthBloc(): super(AuthState().init()) {
    on<InitEvent>((event, emit) => _init(event, emit));
    on<UpdateAccountEvent>((event, emit) => _upAccount(event, emit));
    on<UpdateTokenEvent>((event, emit) => _upToken(event, emit));
    on<UpdateEmailEvent>((event, emit) => _upEmail(event, emit));
    on<UpdateRankEvent>((event, emit) => _upRank(event, emit));
    on<LogoutEvent>((event, emit) => _logout(event, emit));
  }

  void _init(InitEvent event, Emitter<AuthState> emit) {
    emit(state.clone());
  }

  void _upAccount(UpdateAccountEvent event, Emitter<AuthState> emit) {
    state.account = event.account;
    emit(state.clone());
  }

  void _upToken(UpdateTokenEvent event, Emitter<AuthState> emit) {
    state.token = event.token;
    emit(state.clone());
  }

  void _upEmail(UpdateEmailEvent event, Emitter<AuthState> emit) {
    state.email = event.email;
    emit(state.clone());
  }

  void _upRank(UpdateRankEvent event, Emitter<AuthState> emit) {
    state.rank = event.rank;
    emit(state.clone());
  }

  void _logout(LogoutEvent event, Emitter<AuthState> emit) {
    state.account = "";
    state.token = "";
    state.email = "";
    state.rank = 0;
    emit(state.clone());
  }
}

// class TestBloc extends Bloc<TestEvent, AuthState> {
//   final TestRepository _testRepository;

//   TestBloc({required TestRepository testRepository}) : _testRepository = testRepository, super(TestInitial());

//   @override
//   Stream<AuthState> mapEventToState(TestEvent event) async* {
//     if (event is AddEvent) {
//       yield* mapAddEventToState(event.count);
//     }

//     if (event is DecEvent) {
//       yield* mapDecEventToState(event.count);
//     }
//   }
  
//   Stream<AuthState> mapAddEventToState(int count) async* {
//     try {
//       final _count = await _testRepository.add(count);
//       yield Success(_count);
//     } catch(_) {
//       yield Failure();
//     }
//   }
  
//   Stream<AuthState> mapDecEventToState(int count) async* {
//     try {
//       final _count = await _testRepository.dec(count);
//       yield Success(_count);
//     } catch(_) {
//       yield Failure();
//     }
//   }
// }
