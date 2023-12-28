import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/Util/Extension.dart';
import 'package:task_app/ViewState/AppBloc.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: context.getSize().height * 0.05,
                    child: Text("Task List View",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks!.length,
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text("${state.tasks![index].taskName}"),
                          trailing: Text("${state.tasks![index].employee}"),
                          subtitle:
                              Text("${state.tasks![index].taskDiscription}"),
                        ),
                      ),
                    ),
                  )
                ],
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
