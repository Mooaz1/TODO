import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/tasks_cubit/tasks_cubit.dart';
import 'package:todo/presentation/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:todo/shared/dimensions.dart';

import '../../shared/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: context.read<TasksCubit>().scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "TODO",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.width(context) * .03),
          child: SizedBox(
            width: Dimensions.width(context),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height(context) * .02,
                ),
                Expanded(
                    child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: Dimensions.width(context) * .03,
                      mainAxisSpacing: Dimensions.height(context) * .02,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Dismissible(
                    background: Container(
                      color: Colors.red,
                    ),
                    secondaryBackground: Container(
                      color: Colors.green,
                    ),
                    direction: DismissDirection.horizontal,
                    key: Key("$index"),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        print("object");
                      } else {
                        print("omh");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Constansts.colorArray[Random().nextInt(16)],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return CustomBottomSheet();
          },
        ));
  }
}

class TodoField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final IconData icon;
  void Function()? onTap;
  TodoField({
    required this.controller,
    required this.validator,
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width(context) * .7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Constansts.prmiaryColor)),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            fillColor: Constansts.prmiaryColor,
            border: InputBorder.none,
            labelText: label,
            labelStyle: const TextStyle(color: Constansts.prmiaryColor),
            prefixIcon: Icon(
              icon,
              color: Constansts.prmiaryColor,
            )),
      ),
    );
  }
}
