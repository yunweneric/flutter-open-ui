import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_openui/ui/components/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconoir_flutter/regular/circle.dart';
import 'package:iconoir_flutter/solid/check_circle.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/helper.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});

  final TaskCard task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Constant.borderColor, width: 2.0),
                color: Constant.foregroundColor),
            child: const BackButton(),
          ),
        ),
        title: Text(
          'Task Details',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Task Title',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Constant.textColor),
            ),
            subtitle: Text(
              task.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Constant.dark),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                LucideIcons.clipboardEdit,
                color: Constant.textColor,
              ),
            ),
          ),
          const Gap(20.0),
          ListTile(
            title: Text(
              'Due Date',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Constant.textColor),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock4,
                      color: Constant.textColor,
                    ),
                    const Gap(8.0),
                    Text(
                      task.dueDate,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600, color: Constant.dark),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: task.status == 'On Progress'
                        ? Constant.surfaceGreen
                        : Constant.surfacePurple,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(task.status,
                      style: task.status == 'On Progress'
                          ? TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Constant.deepGreen)
                          : const TextStyle()),
                ),
              ],
            ),
          ),
          const Gap(20.0),
          ListTile(
            title: Text(
              'Description',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Constant.textColor),
            ),
            subtitle: Text(
              task.description,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: Constant.dark),
            ),
          ),
          const Gap(20.0),
          Padding(
            padding: Constant.listviewPadding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicHeight(
                child: FlutterImageStack.providers(
                  providers: task.members,
                  totalCount: 4,
                  itemCount: 4,
                  showTotalCount: false,
                  itemRadius: 40,
                  itemBorderWidth: 1.5,
                  itemBorderColor: Constant.borderColor,
                ),
              ),
            ),
          ),
          const Gap(20.0),
          ListTile(
            title: Text(
              'Stages of Task',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Constant.textColor),
            ),
          ),
          const Gap(10.0),
          Flexible(
            child: Column(
              children: List.generate(task.tasks.length, (index) {
                final detailTask = task.tasks[index];
                return Padding(
                  padding: Constant.listviewPadding,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  duration: const Duration(microseconds: 300),
                  decoration: BoxDecoration(
                    color: Constant.backgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      detailTask.isCompleted
                          ? CheckCircleSolid(color: Constant.purple)
                          : Circle(
                        color: Constant.textColor,
                      ),
                      const Gap(16.0),
                      Expanded(
                        child: Text(
                          detailTask.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: detailTask.isCompleted ? null : FontWeight.w600 ,color: detailTask.isCompleted ? Constant.textColor.withOpacity(0.5) : Constant.textColor, decoration: detailTask.isCompleted ? TextDecoration.lineThrough : null),
                        ),
                      )
                    ],
                  ),
                              ),
                );
              },),
            ),
          )
        ],
      ),
    );
  }
}
