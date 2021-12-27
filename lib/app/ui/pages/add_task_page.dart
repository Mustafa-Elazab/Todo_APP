import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/app/controllers/task_controller.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/ui/global_widgets/custom_button.dart';
import 'package:todo_app/app/ui/global_widgets/custom_input_field.dart';
import 'package:todo_app/app/ui/pages/home_page.dart';
import 'package:todo_app/app/ui/theme/theme.dart';
import 'package:filesystem_picker/filesystem_picker.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  String _endTime = "9:00 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedReapet = 'None';
  List<String> reapetList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomInputField(
                  title: 'Title',
                  hint: 'Enter a title text .',
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note",
                        style: titleStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: TextFormField(
                          autofocus: false,
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                          controller: _noteController,
                          style: subTitleStyle,
                          maxLines: 5,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Note",
                            hintStyle: subTitleStyle,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).backgroundColor,
                                  width: 0.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).backgroundColor,
                                  width: 0.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        child: TextFormField(
                          autofocus: false,
                          readOnly: true,
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[500]
                              : Colors.grey[700],
                          //controller: _noteController,
                          style: subTitleStyle,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _getSDCardDirectory();
                                },
                                icon: const Icon(Icons.attach_file)),
                            hintText: "select a document",
                            hintStyle: subTitleStyle,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).backgroundColor,
                                  width: 0.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).backgroundColor,
                                  width: 0.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomInputField(
                  title: 'Date',
                  hint: DateFormat.yMMMMd().format(_dateTime),
                  widget: IconButton(
                      onPressed: () {
                        _getDataFromUser();
                      },
                      icon: const Icon(Icons.date_range_outlined)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: CustomInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(Icons.timer)),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(Icons.timer)),
                    ))
                  ],
                ),
                CustomInputField(
                  title: 'Remind',
                  hint: '$_selectedRemind minutes early',
                  widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList()),
                ),
                CustomInputField(
                  title: 'Reapet',
                  hint: _selectedReapet,
                  widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedReapet = newValue!;
                        });
                      },
                      items: reapetList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Color',
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                        children: List<Widget>.generate(3, (int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? blueColor
                                  : index == 1
                                      ? pinkColor
                                      : yellowColor,
                              child: _selectedColor == index
                                  ? const Icon(
                                      Icons.done,
                                      size: 14,
                                      color: whiteColor,
                                    )
                                  : Container()),
                        ),
                      );
                    })),
                    CustomButton(
                        title: 'Create Task',
                        onTap: () {
                          _validateDate();
                          addTaskDb();

                          Get.offAll(() => const HomePage());
                        },
                        width: MediaQuery.of(context).size.width / 2,
                        height: 52)
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Requird',
        'All Field is Requird !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: whiteColor,
        colorText: Get.isDarkMode ? blackColor : blackColor,
        icon: const Icon(Icons.warning_amber_outlined),
      );
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Get.offAll(() => const HomePage());
        },
      ),
      actions:const [
         Icon(Icons.rounded_corner_outlined),
      ],
    );
  }

  void _getDataFromUser() async {
    DateTime? _picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (_picker != null) {
      setState(() {
        _dateTime = _picker;
      });
    
    } else {
    
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    var timePicker = await _showTimePicker();
    var _formatTime = timePicker.format(context);
    if (timePicker == null) {
     
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }

  void addTaskDb() async {
    int value = await _taskController.addTask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_dateTime),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedReapet,
      color: _selectedColor,
      isComplete: 0,
    ));
    
  }

  _getSDCardDirectory() async {
    Directory directory = await getTemporaryDirectory();
    String? path = await FilesystemPicker.open(
        title: 'save to folder',
        context: context,
        rootDirectory: directory,
        fsType: FilesystemType.folder,
        pickText: 'save file to this folder',
        folderIconColor: Colors.teal);
  }
}
