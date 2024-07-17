import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'team_member_state.dart';

  class TeamMemberCubit extends Cubit<TeamMemberState> {
  TeamMemberCubit() : super(TeamMemberInitial());

  static TeamMemberCubit get(BuildContext context) => BlocProvider.of(context);


}
