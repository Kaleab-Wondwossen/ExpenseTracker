import 'package:expensetracker/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDatePicker extends StatefulWidget {
  final Function(DateTime selectedDate)? onDateSelected;

  const HorizontalDatePicker({super.key, this.onDateSelected});

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  DateTime selectedDate = DateTime.now();
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = selectedDate.subtract(Duration(days: 3));
  }

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (index) => startDate.add(Duration(days: index)));
    final monthLabel = DateFormat.MMMM().format(selectedDate);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    startDate = startDate.subtract(const Duration(days: 7));
                  });
                },
              ),
              Text(
                monthLabel,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    startDate = startDate.add(const Duration(days: 7));
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isSelected = day.day == selectedDate.day &&
                                   day.month == selectedDate.month &&
                                   day.year == selectedDate.year;
      
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedDate = day);
                    if (widget.onDateSelected != null) {
                      widget.onDateSelected!(day);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple.shade100 : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.d().format(day),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat.E().format(day), // Mon, Tue, etc.
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                          ),
                        ),
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: CircleAvatar(radius: 3, backgroundColor: Colors.deepPurple),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: AppSizes.smallGap,
          )
        ],
      ),
    );
  }
}
