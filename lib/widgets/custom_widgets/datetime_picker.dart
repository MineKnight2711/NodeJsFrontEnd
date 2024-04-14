import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanlyquantrasua/configs/colors.dart';
import 'package:quanlyquantrasua/configs/font.dart';

import '../../configs/mediaquery.dart';

class BirthdayDatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;

  const BirthdayDatePickerWidget({Key? key, this.initialDate, this.onChanged})
      : super(key: key);

  @override
  BirthdayDatePickerWidgetState createState() =>
      BirthdayDatePickerWidgetState();
}

class BirthdayDatePickerWidgetState extends State<BirthdayDatePickerWidget> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: mediaWidth(context, 30)),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${_selectedDate?.day ?? "Ngày"}/${_selectedDate?.month ?? "Tháng"}/${_selectedDate?.year ?? "Năm"}",
                      style: CustomFonts.nunitoFont(
                          fontSize: 14.r, color: AppColors.white100),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 30.r,
                      color: AppColors.white100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(primary: Colors.green)
                .copyWith(secondary: Colors.green),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onChanged!(picked);
      });
    }
  }
}
