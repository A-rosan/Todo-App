import 'package:flutter_application_2/modules/counter_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit():super(CounterInitState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int counter=1;

  void minus(){
    counter--;
    emit(CounterMinusState());
  }
  void pluss(){
    counter++;
    emit(CounterPlussState());
  }
}