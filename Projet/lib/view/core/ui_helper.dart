class UiHelper {
  static String getDynamicBackground({String? iconCode}) {
    if (iconCode != null) {
      if (iconCode.endsWith('n')) {
        return 'assets/alwinNight.jpeg';
      } else {
        return 'assets/alwinClouds.jpeg';
      }
    }
    
    // Fallback to time if no code provided
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 18) {
      return 'assets/alwinClouds.jpeg';
    } else {
      return 'assets/alwinNight.jpeg';
    }
  }
}
