import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_task/cubit/cubit.dart';
import 'package:project_task/cubit/states.dart';
import 'package:project_task/widget/buttons.dart';
import 'package:project_task/widget/text_formField.dart';

class AddDialogSheet extends StatefulWidget {
  const AddDialogSheet({this.id = '', this.total, super.key});
  final String id;
  final DocumentSnapshot? total;
  @override
  State<AddDialogSheet> createState() => _AddDialogSheetState();
}

class _AddDialogSheetState extends State<AddDialogSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SimpleDialog(
            alignment: Alignment.bottomCenter,
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(0),
            elevation: 40,
            shadowColor: Colors.black,
            children: [
              BlocProvider(
                create: (context) => TaskBloc(),
                child: BlocConsumer<TaskBloc, TaskStates>(
                    listener: (BuildContext context, TaskStates state) {},
                    builder: (context, state) {
                      ///call Bloc
                      var cu = TaskBloc.get(context);
                      return Builder(builder: (context) {
                        ///fill data to edit
                        if (widget.id.isNotEmpty) {
                          cu.taskTitle.text =
                              widget.total!["TitleTask"].toString();
                          cu.taskTitleString =
                              widget.total!["TitleTask"].toString();
                          cu.dueDate.text = widget.total!["DueDate"].toString();
                          cu.isFinish = widget.total!["IsFinish"];
                        }

                        /// View Add And Edit
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              /// title Popup
                              Row(
                                children: [
                                  Text(
                                    widget.id.isNotEmpty
                                        ? 'Edit Task'
                                        : 'Create New Task',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              /// field Title
                              Row(
                                children: [
                                  Expanded(
                                    child: customTextFormField(
                                      hintText: 'Task title',
                                      textController: cu.taskTitle,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              /// field Due Date
                              Row(
                                children: [
                                  Expanded(
                                      child: customTextFormField(
                                    onTap: () async {
                                      var result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime(DateTime.now().year),
                                          lastDate: DateTime(
                                              DateTime.now().year + 5));
                                      if (result != null) {
                                        setState(() {
                                          cu.datePiker =
                                              DateFormat.yMEd().format(result);
                                        });
                                        cu.fillDueDateController();
                                      }
                                    },
                                    hintText: 'Due Date',
                                    textController: cu.dueDate,
                                    isReadOnly: true,
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ///Button Add Or Edit
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 0),
                                      child: customBtn(
                                        onTap: () {
                                          if (widget.id.isEmpty) {
                                            cu.addTask(context);
                                          } else {
                                            cu.editTask(
                                                context: context,
                                                id: widget.id);
                                          }
                                        },
                                        text: widget.id.isEmpty
                                            ? 'Save Task'
                                            : 'Edit Task',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (widget.id.isNotEmpty)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 0),
                                        child: customBtn(
                                            onTap: () {
                                              cu.deleteTask(
                                                  context: context,
                                                  id: widget.id);
                                            },
                                            text: 'Delete Task',
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      });
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
