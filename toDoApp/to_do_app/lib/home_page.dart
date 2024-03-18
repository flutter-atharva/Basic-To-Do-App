import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/task_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool toEdit = false;

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List taskList = [
    Task(title: "Work on frontend", description: "Complete the UI code and basic functionalities", date: "Mar 18, 2024"),
  ];

  List colors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  void submit(bool toEdit, [index]) {
    if (toEdit == true) {
      taskList[index].title = taskController.text;
      taskList[index].description = descriptionController.text;
      taskList[index].date = dateController.text;
    } else {
      if (taskController.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty && dateController.text.trim().isNotEmpty) {
        taskList.add(Task(title: taskController.text, description: descriptionController.text, date: dateController.text));
      }
    }
    clearController();
    setState(() {});
  }

  void delete(index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void clearController() {
    taskController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void edit(index) {}

  void bottomSheet(bool toEdit, [index]) {
    if (toEdit == true) {
      taskController.text = taskList[index].title;
      descriptionController.text = taskList[index].description;
      dateController.text = taskList[index].date;
    }
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Create Task",
                  style: GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Task",
                      style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w400, color: const Color.fromRGBO(0, 139, 148, 1)),
                    )),
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w400, color: const Color.fromRGBO(0, 139, 148, 1)),
                    )),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Date",
                      style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w400, color: const Color.fromRGBO(0, 139, 148, 1)),
                    )),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2024), lastDate: DateTime(2025));
                    String formatedDate = DateFormat.yMMMd().format(pickedDate!);
                    setState(() {
                      dateController.text = formatedDate;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.date_range_outlined),
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromRGBO(0, 139, 148, 1)), borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (toEdit == true) {
                          submit(true, index);
                        } else {
                          submit(false);
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 139, 148, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      child: const Text("Submit"),
                    )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-do list",
          style: GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 10), blurRadius: 20, spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10),
              color: colors[index % colors.length],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 20, spreadRadius: 0)
                          ],
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            "https://www.taogent.com/noimg/noimg.jpg",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              taskList[index].title,
                              style: GoogleFonts.quicksand(fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(taskList[index].description, style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w500))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        taskList[index].date,
                        style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w500, color: const Color.fromRGBO(132, 132, 132, 1)),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            toEdit = true;
                            bottomSheet(true, index);
                          },
                          icon: const Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          )),
                      IconButton(
                          onPressed: () {
                            delete(index);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearController();
          bottomSheet(false);
        },
        
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
