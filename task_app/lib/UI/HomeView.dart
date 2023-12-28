import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/UI/TaskAssignmentView.dart';
import 'package:task_app/UI/TaskCreationView.dart';
import 'package:task_app/UI/TaskListView.dart';
import 'package:task_app/Util/Extension.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  Widget? currentView;
  var views = <Widget>[
    TaskCreationView(),
    TaskListView(),
    TaskAssignmentView(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentView = views[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFedf2f4),
      appBar: AppBar(
        title: Text("Task App"),
      ),
      body: Container(
        width: context.getSize().width,
        height: context.getSize().height,
        child: currentView,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  backgroundColor: Color(0xFFedf2f4),
                  onClosing: () {},
                  builder: (context) => TaskAssignmentView(),
                );
              },
            );
          },
          child: Icon(Icons.assignment)),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            currentView = views[currentIndex];
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_comment_rounded), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "List")
          ]),
    );
  }
}
