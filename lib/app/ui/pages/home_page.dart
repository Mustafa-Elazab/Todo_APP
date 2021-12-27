import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/controllers/task_controller.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/data/services/notification_service.dart';
import 'package:todo_app/app/data/services/theme_services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app/app/ui/global_widgets/custom_button.dart';
import 'package:todo_app/app/ui/global_widgets/custom_text.dart';
import 'package:todo_app/app/ui/global_widgets/task_widget.dart';
import 'package:todo_app/app/ui/pages/add_task_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_app/app/ui/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _customAppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: [
            CustomText(
              title: DateFormat.yMMMMd().format(DateTime.now()),
              fontSize: 18,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 8,
            ),
            CustomText(
              title: 'Today',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            DatePicker(
              DateTime.now(),
              height: size.height / 8,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: blueColor,
              selectedTextColor: whiteColor,
              dateTextStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              dayTextStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              monthTextStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => const NewTaskPage());
          }),
    );
  }

  _customAppBar() {
    return AppBar(
      elevation: 0.0,
      actions:  const [
         CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.person,
          ),
        ),
      ],
      leading: IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
            NotificationService().instantNotification();
          },
          icon: const Icon(
            Icons.nightlight_round,
          )),
    );
  }

  _showTasks() {
    return Expanded(
        child: Obx(() => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                NotificationService().showNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                    context, _taskController.taskList[index]);
                              },
                              child: TaskTile(
                                _taskController.taskList[index],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                    context, _taskController.taskList[index]);
                              },
                              child: TaskTile(
                                _taskController.taskList[index],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            })));
  }

  void _showBottomSheet(context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 2),
      height: task.isComplete == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyColor : whiteColor,
      child: Column(
        children: [
          Container(
            height: 6,
            width: MediaQuery.of(context).size.width * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Get.isDarkMode ? blueColor : Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          task.isComplete == 1
              ? Container()
              : CustomButton(
                  title: 'Task Completed',
                  onTap: () {
                    _taskController.taskComplete(task.id!);
                    Get.back();
                  },
                  width: MediaQuery.of(context).size.width * .80,
                  height: MediaQuery.of(context).size.height / 14),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            title: 'Delete Task',
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
            width: MediaQuery.of(context).size.width * .80,
            height: MediaQuery.of(context).size.height / 14,
            color: pinkColor,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            title: 'Cancel',
            onTap: () {
              Get.back();
            },
            width: MediaQuery.of(context).size.width * .80,
            height: MediaQuery.of(context).size.height / 14,
            color: Colors.transparent,
            textColor: Get.isDarkMode ? whiteColor : blackColor,
          )
        ],
      ),
    ));
  }
}
