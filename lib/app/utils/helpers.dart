import 'dart:math';

class Helper {
  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 6) {
      return 'Good early morning';
    } else if (hour < 12) {
      return 'Good morning';
    } else if (hour < 14) {
      return 'Good noon';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else if (hour < 20) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  // Generate a random height for each circle within a range
  static double getRandomHeight() {
    final Random random = Random();
    return 50.0 + random.nextInt(100); // Random height between 50 and 150
  }
}
