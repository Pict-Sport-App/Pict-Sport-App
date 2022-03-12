import 'package:psa/models/user_details.dart';

void checkmysportlist() {
  UserDetails.mySportsList!.clear();
  UserDetails.mySportEmoji!.clear();
  for (var entire in UserDetails.sportList!.entries) {
    if (entire.value) {
      UserDetails.mySportsList?.add(entire.key);
    }
  }
  UserDetails.myOfficialSportsList!.clear();
  UserDetails.myOfficialSportEmoji!.clear();
  for(var entre in UserDetails.officialsportMap!.entries){
    if (entre.value==2){
      UserDetails.myOfficialSportsList?.add(entre.key);
    }
  }
  for(int i=0;i<UserDetails.myOfficialSportsList!.length;i++){
    if (UserDetails.myOfficialSportsList![i] == 'Official BasketBall') {
      UserDetails.myOfficialSportEmoji!.add('🏀');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official VolleyBall') {
      UserDetails.myOfficialSportEmoji!.add('🏐');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official TableTennis') {
      UserDetails.myOfficialSportEmoji!.add('🎾');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official Badminton') {
      UserDetails.myOfficialSportEmoji!.add('🏸');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official Cricket') {
      UserDetails.myOfficialSportEmoji!.add('🏏');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official FootBall') {
      UserDetails.myOfficialSportEmoji!.add('⚽');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official Gym') {
      UserDetails.myOfficialSportEmoji!.add('💪');
    }
    if (UserDetails.myOfficialSportsList![i] == 'Official Chess') {
      UserDetails.myOfficialSportEmoji!.add('♟');
    }
  }

  for (int i = 0; i < UserDetails.mySportsList!.length; i++) {
    if (UserDetails.mySportsList![i] == 'BasketBall') {
      UserDetails.mySportEmoji!.add('🏀');
    }
    if (UserDetails.mySportsList![i] == 'VolleyBall') {
      UserDetails.mySportEmoji!.add('🏐');
    }
    if (UserDetails.mySportsList![i] == 'TableTennis') {
      UserDetails.mySportEmoji!.add('🎾');
    }
    if (UserDetails.mySportsList![i] == 'Badminton') {
      UserDetails.mySportEmoji!.add('🏸');
    }
    if (UserDetails.mySportsList![i] == 'Cricket') {
      UserDetails.mySportEmoji!.add('🏏');
    }
    if (UserDetails.mySportsList![i] == 'FootBall') {
      UserDetails.mySportEmoji!.add('⚽');
    }
    if (UserDetails.mySportsList![i] == 'Gym') {
      UserDetails.mySportEmoji!.add('💪');
    }
    if (UserDetails.mySportsList![i] == 'Chess') {
      UserDetails.mySportEmoji!.add('♟');
    }
  }

}
