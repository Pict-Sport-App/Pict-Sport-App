class UserDetails{
  static String? email;
  static String? name;
  static String? misId;
  static Map<String,bool>? sportList={
    'BasketBall':false, //🏀 BB
    'VolleyBall':false,//🏐 VB
    'TableTennis':false,  //🎾 TT
    'Badminton': false,//🏸  BT
    'Cricket':false,//🏏  CR
    'FootBall':false,//⚽ FB
    'Chess':false,//♟ CH
    'Gym':false,//💪 GY
  };
  //-1 - not interested
  //0 - not requested
  //1 - requested
  //2 - official part
  static Map<String,int>? officialsportMap={
    'Official BasketBall':0, //🏀 BB
    'Official VolleyBall':0,//🏐 VB
    'Official TableTennis':0,  //🎾 TT
    'Official Badminton': 0,//🏸  BT
    'Official Cricket':0,//🏏  CR
    'Official FootBall':0,//⚽ FB
    'Official Chess':0,//♟ CH
    'Official Gym':0,//💪 GY
  };
  static String? uid;
  static String? photourl;
  static List? mySportsList=[];
  static List? mySportEmoji=[];
  static List? myOfficialSportsList=[];
  static List? myOfficialSportEmoji=[];
  static bool? isAdmin;
  static String? birthday;
  static String? location;
  static String? headline;
  static String? rollNo;
  static String? achivement;
  static String? aboutMe;
  static String? instaUrl;
  static String? twitterUrl;
  static String? linkedInUrl;
  static String? whatAppNo;
  static bool? isDeveloper;
}

