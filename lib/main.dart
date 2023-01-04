import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CounterBloc(),
              child: CounterPage(),
            ),
          ],
          child: CounterPage(),
        ));
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOC Counter'),
      ),
      body: Column(
        children: [
          Center(
            child: BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Column(
                  children: [
                    Text(
                      '$count',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(

                          onPressed: () {
                            context.read<CounterBloc>().add(Increment());
                          },
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(

                          onPressed: () {
                            if(count > 0){
                              context.read<CounterBloc>().add(Decrement());
                            }
                          },
                          child: Icon(
                            Icons.minimize,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],);},),),
        ],
      ),
    );
  }
}

abstract class CounterEvent {}

class Increment extends CounterEvent {
}

class Decrement extends CounterEvent {
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}

