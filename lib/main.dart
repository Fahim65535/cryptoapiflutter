import 'package:crypto_bloc_api/blocs/crypto/crypto_bloc.dart';
import 'package:crypto_bloc_api/pages/home_page.dart';
import 'package:crypto_bloc_api/services/data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CryptoRepo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          colorScheme:
              const ColorScheme.dark().copyWith(secondary: Colors.white),
        ),
        home: BlocProvider(
          create: (context) => CryptoBloc(
            cryptoRepository: context.read<CryptoRepo>(),
          )..add(Start()),
          child: const HomePage(),
        ),
      ),
    );
  }
}

// /// The events which `CounterBloc` will react to.
// abstract class CounterEvent {}

// /// Notifies bloc to increment state.
// class CounterIncrementPressed extends CounterEvent {}

// /// A `CounterBloc` which handles converting `CounterEvent`s into `int`s.
// class CounterBloc extends Bloc<CounterEvent, int> {
//   /// The initial state of the `CounterBloc` is 0.
//   CounterBloc() : super(0) {
//     /// When a `CounterIncrementPressed` event is added,
//     /// the current `state` of the bloc is accessed via the `state` property
//     /// and a new state is emitted via `emit`.
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//   }



// Future<void> main() async {
//   /// Create a `CounterBloc` instance.
//   final bloc = CounterBloc();

//   /// Access the state of the `bloc` via `state`.
//   print(bloc.state); // 0

//   /// Interact with the `bloc` to trigger `state` changes.
//   bloc.add(CounterIncrementPressed());

//   /// Wait for next iteration of the event-loop
//   /// to ensure event has been processed.
//   await Future.delayed(Duration.zero);

//   /// Access the new `state`.
//   print(bloc.state); // 1

//   /// Close the `bloc` when it is no longer needed.
//   await bloc.close();
// }

// }

