import 'package:attendance/controller/team_member/team_member_cubit.dart';
import 'package:attendance/core/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cards/team_member_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late final TeamMemberCubit _cubit = TeamMemberCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomTextFormField(
            hint: 'search term',
            controller: _controller,
            onChange: (value) {
              if (value.length >= 3 || value.isEmpty) {
                _cubit.search(value);
              }
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<TeamMemberCubit, TeamMemberState>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, i) {
                    return TeamMemberCard(
                      data: _cubit.searchList[i],
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: _cubit.searchList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
