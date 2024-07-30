import 'package:attendance/controller/team_member/team_member_cubit.dart';
import 'package:attendance/core/app_helper/app_toast.dart';
import 'package:attendance/core/constants/app_size.dart';
import 'package:attendance/model/team_member_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_helper/show_dialog.dart';
import '../../core/custom_widgets/do_you_want_dialog.dart';
import '../../core/style/app_colors.dart';
import 'row_icon_text.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({super.key, required this.data});

  final TeamMemberModel data;

  Future<void> _onPhoneTap() async {
    final Uri uri = Uri.parse("tel:+2${data.phone}");

    if (!await launchUrl(uri)) {
      showErrorToast('the phone number have a problem');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TeamMemberCubit cubit = TeamMemberCubit.get(context);
    return Stack(
      children: [
        Container(
          height: AppSize.heightScale(context, 118),
          padding: const EdgeInsets.only(
            top: 18,
            right: 10,
            left: 10,
            bottom: 10,
          ),
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowIconText(
                    icon: Icons.abc,
                    text: data.name,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _onPhoneTap(),
                    child: RowIconText(
                      icon: Icons.phone,
                      iconColor: AppColors.softOrange,
                      text: data.phone,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.softOrange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.accessibility_sharp,
                    text: data.age.toString(),
                    textStyle: const TextStyle(
                        fontSize: 16, color: AppColors.lightGrey),
                  ),
                  const SizedBox(height: 8),
                  RowIconText(
                    icon: Icons.timelapse_sharp,
                    text: DateFormat("dd/MM/yyyy - hh:mm")
                        .format(data.dateTime)
                        .toString(),
                    textStyle: const TextStyle(
                        fontSize: 16, color: AppColors.lightGrey),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Qr code
                  GestureDetector(
                    onTap: () => cubit.qrScreenshot(
                      context: context,
                      memberId: data.id,
                      teamId: data.teamId,
                      subTeamId: data.subTeamId,
                      memberName:data.name,
                    ),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: QrImageView(
                        data: data.id,
                        version: QrVersions.auto,
                        gapless: false,
                      ),
                    ),
                  ),
                  const Spacer(),

                  /// Delete
                  GestureDetector(
                    onTap: () => showPopupDialog(
                      context,
                      DoYouWantDialog(
                        title: 'Do You Want To Delete',
                        deletedItem: 'Member: ${data.name}',
                        whenYesTap: () {
                          cubit.deleteTeamMember(
                            teamId: data.teamId,
                            subTeamId: data.subTeamId,
                            memberId: data.id,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.lightGrey.withOpacity(0.3),
                      ),
                      child: const Icon(
                        Icons.delete_forever,
                        size: 19,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        ///
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor),
            child: Text(
              data.position,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
