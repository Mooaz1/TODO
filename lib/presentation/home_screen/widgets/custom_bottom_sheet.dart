import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/logic/tasks_cubit/tasks_cubit.dart';

import '../../../shared/constants.dart';
import '../../../shared/dimensions.dart';
import '../home_screen.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.read<TasksCubit>().isAddShow
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FloatingActionButton(
                  backgroundColor: Constansts.prmiaryColor,
                  child: const Icon(
                    Icons.add,
                    color: Constansts.secColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print("object");
                    }
                  },
                ),
              )
            : SizedBox(),
        SizedBox(
            height: Dimensions.height(context) * .1,
            width: Dimensions.width(context) * .2,
            child: FloatingActionButton(
              backgroundColor: Constansts.secColor,
              child: Icon(
                Icons.edit,
                color: Constansts.prmiaryColor,
                size: Dimensions.height(context) * .04,
              ),
              onPressed: () {
                if (!context.read<TasksCubit>().isAddShow) {
                  context
                      .read<TasksCubit>()
                      .scaffoldKey
                      .currentState!
                      .showBottomSheet(
                        enableDrag: false,
                        (context) => SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height(context) * .05,
                                  ),
                                  TodoField(
                                      controller: titleController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter title";
                                        }
                                      },
                                      icon: Icons.title,
                                      label: "Title"),
                                  SizedBox(
                                    height: Dimensions.height(context) * .01,
                                  ),
                                  TodoField(
                                      controller: descriptionController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Description";
                                        }
                                      },
                                      icon: Icons.description,
                                      label: "Description"),
                                  SizedBox(
                                    height: Dimensions.height(context) * .01,
                                  ),
                                  TodoField(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2050, 9, 7))
                                            .then((value) {
                                          setState(() {
                                            dateController.text =
                                                DateFormat.yMd().format(value!);
                                          });
                                        });
                                      },
                                      controller: dateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Date";
                                        }
                                      },
                                      icon: Icons.date_range,
                                      label: "Date"),
                                  SizedBox(
                                    height: Dimensions.height(context) * .01,
                                  ),
                                  TodoField(
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          setState(() {
                                            timeController.text =
                                                value!.format(context);
                                          });
                                        });
                                      },
                                      controller: timeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter time";
                                        }
                                      },
                                      icon: Icons.watch_later_rounded,
                                      label: "time"),
                                  SizedBox(
                                    height: Dimensions.height(context) * .01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );

                  context.read<TasksCubit>().changeIsAddShow();
                  print(context.read<TasksCubit>().isAddShow);
                } else {
                  Navigator.pop(context);

                  context.read<TasksCubit>().changeIsAddShow();
                  titleController.clear();
                  descriptionController.clear();
                  dateController.clear();
                  timeController.clear();
                  print(context.read<TasksCubit>().isAddShow);
                }
              },
            )),
      ],
    );
  }
}
