import 'package:attendance/controller/attendance/attendance_cubit.dart';
import 'package:attendance/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/style/app_colors.dart';
import 'row_icon_text.dart';

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({super.key, required this.data});

  final AttendanceModel data;

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  late final AttendanceCubit _cubit = AttendanceCubit.get(context);
  String memberName = '';
  String teamName = '';
  String subTeamName = '';

  @override
  void initState() {
    super.initState();
    _fillData();
  }

  Future _fillData() async {
    final Map<String, String>? data = await _cubit.getMemberData(
      teamId: widget.data.teamId,
      subTeamId: widget.data.subTeamId,
      memberId: widget.data.memberId,
    );
    if (data != null) {
      teamName = data['team_name']!;
      subTeamName = data['sub_team_name']!;
      memberName = data['member_name']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowIconText(
                icon: Icons.accessibility,
                text: memberName,
                space: 2,
                iconColor: AppColors.softOrange,
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.softOrange,
                ),
              ),
              const SizedBox(height: 8),
              RowIconText(
                icon: Icons.account_balance_wallet_outlined,
                text: teamName,
                space: 2,
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              RowIconText(
                icon: Icons.account_tree_sharp,
                text: subTeamName,
                space: 2,
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              RowIconText(
                icon: Icons.timelapse_sharp,
                text: DateFormat("dd/MM/yyyy - hh:mm")
                    .format(widget.data.dateTime),
                textStyle: const TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
