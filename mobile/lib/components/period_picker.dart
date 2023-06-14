import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PeriodType { week, month, year }

class PeriodPicker extends ConsumerStatefulWidget {
  final Function(PeriodType type) onTabChanged;
  final PeriodType defaultPeriod;

  const PeriodPicker(
      {Key? key,
      required this.onTabChanged,
      this.defaultPeriod = PeriodType.month})
      : super(key: key);

  @override
  ConsumerState<PeriodPicker> createState() => _PeriodPickerConsumerState();
}

class _PeriodPickerConsumerState extends ConsumerState<PeriodPicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int getInitialTabIndex() {
    switch (widget.defaultPeriod) {
      case PeriodType.week:
        return 0;
      case PeriodType.month:
        return 1;
      case PeriodType.year:
        return 2;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: getInitialTabIndex(),
    );
    _tabController.addListener(() {
      PeriodType type = PeriodType.month;
      switch (_tabController.index) {
        case 0:
          type = PeriodType.week;
          break;
        case 1:
          type = PeriodType.month;
          break;
        case 2:
          type = PeriodType.year;
          break;
        default:
          return;
      }
      widget.onTabChanged(type);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    return Container(
      height: 30.0,
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          color: highlightColor,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: highlightColor,
        splashFactory: NoSplash.splashFactory,
        tabs: [
          Tab(
            child: Text(
              'Week',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Tab(
            child: Text(
              'Month',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Tab(
            child: Text(
              'Year',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
