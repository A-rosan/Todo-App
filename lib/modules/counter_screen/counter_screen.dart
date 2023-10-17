import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/counter_screen/cubit/cubit.dart';
import 'package:flutter_application_2/modules/counter_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text(
                        "minus",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).pluss();
                      },
                      child: Text(
                        "pluss",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )),
        listener: (context, state) {},
      ),
    );
  }
}
