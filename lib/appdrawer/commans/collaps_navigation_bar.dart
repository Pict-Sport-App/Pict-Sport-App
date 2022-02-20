import 'package:flutter/material.dart';
import 'package:psa/appdrawer/model/navigation_model.dart';
import 'package:psa/models/userDetails.dart';
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
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            UserDetails.photourl.toString()),
                        radius: 60,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        UserDetails.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        UserDetails.misId.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            UserDetails.photourl.toString()),
                        radius: 20,
                      ),
                      const SizedBox(
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
