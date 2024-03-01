import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/Screen/mobile/add_dialog_Sheet.dart';
import 'package:project_task/cubit/cubit.dart';
import 'package:project_task/cubit/states.dart';
import 'package:project_task/service/databese.dart';
import 'package:project_task/widget/buttons.dart';

class IndexScreenMob extends StatefulWidget {
  const IndexScreenMob({super.key});

  @override
  State<IndexScreenMob> createState() => _IndexScreenMobState();
}

class _IndexScreenMobState extends State<IndexScreenMob> {
  Stream? tasksStream;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    tasksStream = await DatabaseMethods().getAllTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskStates>(
        listener: (BuildContext context, TaskStates state) {},
        builder: (context, state) {
          var cu = TaskBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.white,
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Text(
                  'Good Morning',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          getData();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 30,
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF00CA5D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Text(
                            'All',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 20,
                          ),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 202, 93, 0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Text(
                            'Not Done',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF00CA5D),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 30,
                          ),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 202, 93, 0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 202, 93, 1),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: tasksStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds =
                                      snapshot.data.docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 20,
                                        top: 8),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddDialogSheet(
                                                id: ds["ID"],
                                                total: ds,
                                              );
                                            },
                                            barrierColor: Colors.transparent,
                                            useSafeArea: true);
                                      },
                                      child: Container(
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${ds["TitleTask"]}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'Due Date: ${ds["DueDate"]}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cu.editIsFinishTask(
                                                  context: context,
                                                  id: ds["ID"],
                                                  dueDate: ds["DueDate"],
                                                  isFinish: ds["IsFinish"],
                                                  taskTitle: ds["TitleTask"],
                                                );
                                              },
                                              child: ds["IsFinish"] == true
                                                  ? Image.asset(
                                                      "assets/image/Group 6.png",
                                                      width: 40,
                                                      height: 40,
                                                    )
                                                  : Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors
                                                              .grey.shade200),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data.docs.length,
                              )
                            : Container();
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        child: customBtn(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddDialogSheet();
                                  },
                                  barrierColor: Colors.transparent,
                                  );
                            },
                            text: 'Create Task'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
