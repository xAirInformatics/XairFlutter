
import 'package:flutter/material.dart';
import 'package:xair/screens/All%20Flights/all_flights.dart';
import 'package:xair/screens/home/home.dart';
import '../consts/style.dart';

class Sidebar extends StatefulWidget {
  Sidebar(this.active);

  final String active;

  @override
  _SidebarState createState() => _SidebarState(this.active);
}

class _SidebarState extends State<Sidebar> {
  _SidebarState(this.active);

  final String active;

  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 70),
        width: _isHovering ? 200 : 50, // Change width based on hover state
        color: kBackgroundLightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // scrollDirection: Axis.vertical,
          children: [
            _buildSidebarItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                active: active == 'Home' ? true : false),
            _buildSidebarItem(
                icon: Icons.airplanemode_active_outlined,
                label: 'All Flights',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllFlights()),
                  );
                },
                active: active == 'All Flights' ? true : false),
            _buildSidebarItem(
              icon: Icons.warning_amber_outlined,
              label: 'All Alerts',
              active: active == 'All Alerts' ? true : false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllFlights()),
                );
              },
            ),
            _buildSidebarItem(
              icon: Icons.settings,
              label: 'Setting',
              active: active == 'Setting' ? true : false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllFlights()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem(
      {required IconData icon,
      required String label,
      required bool active,
      required void Function() onTap }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: active
              ? const Border(
                  left: BorderSide(color: kActiveIconColor, width: 5))
              : const Border(
                  left: BorderSide(color: Colors.transparent, width: 5)),
          color: active ? const Color(0x33333333) : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: active ? kActiveIconColor : kUnActiveIconColor),
              if (_isHovering) ...[
                const SizedBox(width: 12),
                Text(label,
                    style: TextStyle(
                        color: active ? kActiveIconColor : kUnActiveIconColor)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
