import 'package:flutter/material.dart';
// import 'package:flutter_application_2/modules/archive_screen/archive_screen.dart';
// import 'package:flutter_application_2/modules/done_screen/done_screen.dart';
// import 'package:flutter_application_2/modules/tasks_screen/tasks_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';
// import 'package:flutter_application_2/shared/components/constants.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});
  

  GlobalKey scafKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Color defualtColor= const Color.fromARGB(255, 8, 0, 122);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppInsertDatabase){
            Navigator.pop(context);
          }
        },
          builder: (context, state) {
            AppCubit cubit=AppCubit.get(context);
            return Scaffold(
              key: scafKey,
              appBar: AppBar(
                backgroundColor:defualtColor,
                title: Text(
                  cubit.titles[cubit.screenIndex],
                  style:const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              body: cubit.screens[cubit.screenIndex],
              floatingActionButton: FloatingActionButton(
                backgroundColor:defualtColor,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defualtTxtForm(
                                        //title
                                        iconColor:defualtColor,
                                        controller: titleController,
                                        type: TextInputType.text,
                                        label: "Title",
                                        onSubmitted: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Title must not be empty";
                                          }
                                        },
                                        radius: 20.0,
                                        prefixIcon: Icons.title),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defualtTxtForm(
                                        //time picker
                                        isRead: true,
                                        iconColor:defualtColor,
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        label: "Time",
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value.format(context));
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Time must not be empty";
                                          }
                                          return null;
                                        },
                                        radius: 20.0,
                                        prefixIcon: Icons.more_time_outlined),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defualtTxtForm(
                                        //date picker
                                        isRead: true,
                                        iconColor:defualtColor,
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        label: "Date",
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse("2023-10-24"),
                                          ).then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Date must not be empty";
                                          }
                                          return null;
                                        },
                                        radius: 20.0,
                                        prefixIcon: Icons.date_range_outlined),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defualtButton(
                                      color: defualtColor,
                                      text: "Submit",
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.insertDatabase(
                                            title: titleController.text,
                                            time: timeController.text,
                                            date: dateController.text,
                                          );
                                          
                                        }
                                      },
                                      isUpperCase: false,
                                      raduis: 20.0,
                                      fontSize: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                child:const Icon(Icons.add,color: Colors.white,),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white70,
                unselectedItemColor: Colors.grey,                
                fixedColor:defualtColor,
                onTap: (index) {
                 cubit.changeIndex(index);
                },
                currentIndex: cubit.screenIndex,
                items:const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: "tasks",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: "done",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_sharp),
                    label: "archive",
                  ),
                ],
              ),
            );
          },
          ),
    );
  }

  
}
