import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/Model/TaskModel.dart';
import 'package:task_app/Util/Extension.dart';
import 'package:task_app/ViewState/AppBloc.dart';

class TaskAssignmentView extends StatefulWidget {
  const TaskAssignmentView({super.key});

  @override
  State<TaskAssignmentView> createState() => _TaskAssignmentViewState();
}

class _TaskAssignmentViewState extends State<TaskAssignmentView> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AppBloc>(context);
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is AppInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AppBlocLoadedState) {
            return Container(
              width: context.getSize().width,
              height: context.getSize().height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: context.getSize().height * 0.05,
                      child: Text("Task Assignment",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    if (state.tasks != null && state.tasks!.isNotEmpty) ...{
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: context.getSize().width * 0.8,
                            height: context.getSize().height * 0.08,
                            child: DropdownButton<TaskModel?>(
                              isExpanded: true,
                              hint: Text("Task",
                                  style:
                                      GoogleFonts.roboto(color: Colors.grey)),
                              value: state.taskForAssignnt,
                              items: state.tasks!.map((TaskModel value) {
                                return DropdownMenuItem<TaskModel>(
                                  value: value,
                                  child: Text(value.taskName ?? ""),
                                );
                              }).toList(),
                              onChanged: (_) {
                                state.taskForAssignnt = _;
                                setState(() {});
                              },
                              underline: SizedBox.shrink(),
                            )),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: context.getSize().width * 0.8,
                            height: context.getSize().height * 0.08,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Assign to",
                                  style:
                                      GoogleFonts.roboto(color: Colors.grey)),
                              value: state.taskForAssignnt?.employee,
                              items: state.employees.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {
                                state.taskForAssignnt?.employee = _;
                                setState(() {});
                              },
                              underline: SizedBox.shrink(),
                            )),
                      )
                    } else ...{
                      Card(
                        child: Container(
                          width: context.getSize().width * 0.7,
                          height: context.getSize().width * 0.4,
                          alignment: Alignment.center,
                          child:
                              Text("Tasks Are Empty...Please Create any task"),
                        ),
                      )
                    },
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: context.getSize().width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel",
                                style: GoogleFonts.roboto(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!state.taskForAssignnt!.taskName
                                      .isNullOrEmpty() &&
                                  !state.taskForAssignnt!.employee
                                      .isNullOrEmpty()) {
                                bloc.add(AppSaveEvent(
                                    currentTask: state.taskForAssignnt));
                                Navigator.pop(context);
                              } else {
                                var snackBar = SnackBar(
                                  content: Text(
                                    "Task name can not be empty",
                                    style:
                                        GoogleFonts.roboto(color: Colors.red),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor:
                                      Color.fromARGB(255, 231, 231, 231),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text("Save",
                                style: GoogleFonts.roboto(color: Colors.white)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        });
  }
}
