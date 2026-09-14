import 'package:flutter/material.dart';
import 'package:guidance/services/auth/logout_users.dart';

class AppNavigation {
  // ============================================================
  // APP BAR
  // ============================================================

  static PreferredSizeWidget appBar({
    required BuildContext context,
    required String title,
    required String role,
    VoidCallback? onBack,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 55,
      backgroundColor: const Color(0xFF048C6C),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.12,
            child: IconButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              icon: const Icon(Icons.navigate_before, size: 20),
              onPressed:
                  onBack ??
                  () {
                    navigateHome(context, role);
                  },
            ),
          ),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Archivo_black',
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.12,
            child: IconButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              icon: const Icon(Icons.logout, size: 20),
              onPressed: () {
                logoutModal(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR
  // ============================================================

  static Widget bottomNavigationBar({
    required BuildContext context,
    required String role,
    required int currentIndex,
    required ValueChanged<int> onIndexChanged,
  }) {
    return SizedBox(
      height: 65,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF048C6C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,

        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.white,
        ),

        onTap: (index) {
          // Update current navigation index
          onIndexChanged(index);

          // HOME
          if (index == 0) {
            navigateHome(context, role);
            return;
          }

          // REFER
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/referStudents');
            return;
          }

          // SESSION / CHILD
          if (index == 2) {
            if (role == 'Student') {
              Navigator.pushReplacementNamed(context, '/sessions');
            } else {
              Navigator.pushReplacementNamed(context, '/monitorChild');
            }
            return;
          }

          // PROFILE
          if (index == 3) {
            Navigator.pushReplacementNamed(context, getProfileRoute(role));
            return;
          }

          // NOTIFICATIONS
          if (index == 4) {
            if (role == 'Student') {
              Navigator.pushReplacementNamed(context, '/studentNotifications');
            }
            return;
          }
        },

        items: [
          // HOME
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          // REFER
          const BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Refer',
          ),

          // SESSION / CHILD
          BottomNavigationBarItem(
            icon: role == 'Guardian' || role == 'Parent'
                ? const Icon(Icons.child_care)
                : const Icon(Icons.calendar_today_outlined),
            label: role == 'Guardian' || role == 'Parent' ? 'Child' : 'Session',
          ),

          // PROFILE
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),

          // NOTIFICATIONS
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notif',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HOME NAVIGATION
  // ============================================================

  static void navigateHome(BuildContext context, String role) {
    if (role == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    }

    if (role == 'Parent') {
      Navigator.pushReplacementNamed(context, '/parentDashboard');
      return;
    }

    if (role == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/guardianDashboard');
      return;
    }

    if (role == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
      return;
    }
  }

  // ============================================================
  // PROFILE NAVIGATION
  // ============================================================

  static String getProfileRoute(String role) {
    if (role == 'Student') {
      return '/studentProfile';
    }

    if (role == 'Parent') {
      return '/parentProfile';
    }

    if (role == 'Guardian') {
      return '/guardianProfile';
    }

    if (role == 'Faculty') {
      return '/facultyProfile';
    }

    // Default
    return '/studentProfile';
  }

  // ============================================================
  // LOGOUT CONFIRMATION MODAL
  // ============================================================

  static void logoutModal(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),

          title: const Text('Logout'),

          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Are you sure you want to log out?')],
          ),

          actions: [
            // NO
            TextButton(
              onPressed: () {
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('No'),
            ),

            // YES
            TextButton(
              onPressed: () {
                logout(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  static Future<void> logout(BuildContext context) async {
    // Close confirmation dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Show logging out dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),

          contentTextStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),

          title: const Text('Logging Out'),

          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),

              SizedBox(height: 20),

              Text('Please wait'),
            ],
          ),
        );
      },
    );

    // Keep your original 2-second delay
    await Future.delayed(const Duration(seconds: 2));

    final user = await LogoutUsers.logout();

    // Go to login page
    if (user == 'session_clear' && context.mounted) {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }
}
