import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var tasks=AppCubit.get(context).newTasks;
        return ListView.separated(
      itemBuilder:(context,index)=>tasksItems(tasks[index],context) ,
      separatorBuilder: (context,index)=>Container(
        width: double.infinity,
        height: 0.5,
        color:Colors.grey,
      ),
      itemCount: tasks.length,
      );
      },
      );
  }
}