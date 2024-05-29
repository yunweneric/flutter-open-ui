import 'package:flutter/material.dart';
import 'package:flutter_openui/ui/components/helper.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key, required this.focusedDate});

  final DateTime focusedDate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      children: [
        listHeading(context,
            heading:
                'Tasks of ${focusedDate.day} ${DateFormat('MMMM').format(focusedDate)}'),
        const Gap(20.0),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final card = calendarCards[index];
              return Row(
                children: [
                  Text('${card.startTime.replaceRange(card.startTime.length - 3, card.startTime.length, '')}\n${card.startTime.substring(card.startTime.length - 2)}', textAlign: TextAlign.center,),
                  const Gap(20.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: card.backgroundColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Constant.dark),
                          ),
                          const Gap(8.0),
                          Text(card.description),
                          const Gap(8.0),
                          Text(
                            '${card.startTime}-${card.endTime}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Constant.dark),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const Column(
                  children: [
                    Gap(10.0),
                    Divider(),
                    Gap(10.0),
                  ],
                ),
            itemCount: calendarCards.length)
      ],
    );
  }
}

class CalendarCard {
  String title;
  String description;
  String startTime;
  String endTime;
  Color backgroundColor;

  CalendarCard(
      {required this.title,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.backgroundColor});
}

List<CalendarCard> calendarCards = [
  CalendarCard(
    title: 'Meeting with Client',
    description:
        'To discuss about the upcoming project & organization of figma files.',
    startTime: '08:30 AM',
    endTime: '09:30 AM',
    backgroundColor: const Color(0xFFB692F6).withOpacity(0.15),
  ),
  CalendarCard(
    title: 'Lunch Break',
    description: 'To discuss about the upcoming meeting.',
    startTime: '09:30 AM',
    endTime: '10:30 AM',
    backgroundColor: const Color(0xFFFDEAEB),
  ),
  CalendarCard(
    title: 'Dailly Stand-Up',
    description:
        'A stand-up meeting is a meeting in which attendees typically participate while standing. The discomfort..',
    startTime: '10:30 AM',
    endTime: '11:30 AM',
    backgroundColor: const Color(0xFFE8F5F3),
  ),
];
