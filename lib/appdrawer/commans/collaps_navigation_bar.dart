// import 'package:drawer/model/navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:psa/appdrawer/model/navigation_model.dart';
import 'package:psa/screens/Home/table_tennis/requests.dart';
import 'package:psa/screens/announcements/announcement_screen.dart';
// import '../dashboard_screen.dart';
import '../thems.dart';
import 'collapsing_list_tile.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<CollapsingNavigationDrawer> createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 270;
  double minWidth = 77;
  int currentSelectedIndex = 78;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  @override
  @override
  void initState() {

    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);

  }

  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }
  Widget getWidget(context, widget) {
    return Container(
      width: widthAnimation.value,
      color: drawerBackgroundColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            widthAnimation.value >= 250
                ? Column(
                    children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://lh3.googleusercontent.com/a-/AOh14GiI2oRbxg9hBNUSaJE4WVIJMJpRrGHAubWB-BpTzw=s96-c"),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Dhiraj Darker",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "C2K20106749@ms.pict.edu",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Column(
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://lh3.googleusercontent.com/a-/AOh14GiI2oRbxg9hBNUSaJE4WVIJMJpRrGHAubWB-BpTzw=s96-c"),
                        radius: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
            const Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: navigationItems.length,
                  itemBuilder: (context, counter) {
                    return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          currentSelectedIndex = counter;
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const Request();
                          }));
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      animationController: _animationController,
                      title: navigationItems[counter].title,
                      num : navigationItems[counter].num,
                    );
                  },),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                // Icons.chevron_left,
                color: Colors.white,
                size: 43, icon: AnimatedIcons.close_menu,
                progress: _animationController,
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
