import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/Util/Extension.dart';
import 'package:task_app/ViewState/AppBloc.dart';

class TaskCreationView extends StatefulWidget {
  const TaskCreationView({super.key});

  @override
  State<TaskCreationView> createState() => _TaskCreationViewState();
}

class _TaskCreationViewState extends State<TaskCreationView> {
  final _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: context.getSize().height * 0.05,
                        child: Text("Task Creation",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: context.getSize().width * 0.8,
                          height: context.getSize().height * 0.08,
                          child: TextFormField(
                            controller: state.txtTaskName!,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text("Name",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black)),
                                hintText: "Enter Task Name",
                                hintStyle:
                                    GoogleFonts.roboto(color: Colors.grey)),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: context.getSize().width * 0.8,
                          height: context.getSize().height * 0.2,
                          child: TextField(
                            minLines: 1,
                            maxLines: 6,
                            controller: state.txtTaskDescription!,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text("Description",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black)),
                                hintText: "Enter Task Description",
                                hintStyle:
                                    GoogleFonts.roboto(color: Colors.grey)),
                          ),
                        ),
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
                              value: state.currentTask?.employee,
                              items: state.employees.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {
                                state.currentTask?.employee = _;
                                setState(() {});
                              },
                              underline: SizedBox.shrink(),
                            )),
                      ),
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
                                bloc.add(AppClearEvent(
                                    currentTask: state.currentTask));
                              },
                              child: Text("Clear",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  state.currentTask!.taskName =
                                      state.txtTaskName!.text;
                                  state.currentTask!.taskDiscription =
                                      state.txtTaskDescription!.text;
                                  bloc.add(AppSaveEvent(
                                      currentTask: state.currentTask));
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
                                  style:
                                      GoogleFonts.roboto(color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
