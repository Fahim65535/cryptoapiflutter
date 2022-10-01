import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/currency.dart';
import '../../model/data_error.dart';
import '../../services/data_repo.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepo _cryptoRepository;

  CryptoBloc({required CryptoRepo cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.start()) {
    on<Start>((event, emit) => _start(emit));
    on<RefreshCoins>((event, emit) => _getCoins(emit));
  }

  Future<CryptoState> _getCoins(Emitter<CryptoState> emit) async {
    try {
      // Get a list of our coins
      final coins = await _cryptoRepository.getCurrencies();
      // If successful, the state is updated with the coins we have, with an updated status.
      // It is updated by calling emit(new state).
      emit(state.copyWith(coins: coins, status: Status.loaded));
      return state;
    } on DataError catch (err) {
      // fails we update the state accordingly.
      emit(state.copyWith(
        failure: err,
        status: Status.error,
      ));
      return state;
    }
  }

  Future<CryptoState> _start(Emitter<CryptoState> emit) async {
    state.copyWith(status: Status.loading);
    return _getCoins(emit);
  }
}
