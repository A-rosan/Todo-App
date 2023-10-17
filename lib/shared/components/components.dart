import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';

Widget defualtButton({
  double width = double.infinity,
  double? height,
  Color color = Colors.blue,
  Color fontColor = Colors.white,
  double fontSize = 20,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double raduis = 0.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defualtTxtForm({
  //carefull
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,

  //icons
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixFunction,
  
  bool isClicAble = true,
  bool isRead = false,
  bool isPassword = false,
  Color iconColor = Colors.grey,
  Color textFormColor = Colors.white,

  //style
  double radius = 0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClicAble,
      validator: validator,
      obscureText: isPassword,
      readOnly: isRead,
      decoration: InputDecoration(
          fillColor: textFormColor,
          label: Text(label),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFunction,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor,
                  ),
                )
              : null),
    );

    
Widget tasksItems(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:const Color.fromARGB(255, 8, 0, 122),
              radius: 40.0,
              child: Text(
                "${model['time']}",
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style:const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 0, 122),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            ),
           const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .upateData(status: 'done', id: model['id']);
              },
              icon:const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
           const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .upateData(status: 'archive', id: model['id']);
              },
              icon:const Icon(
                Icons.archive,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
