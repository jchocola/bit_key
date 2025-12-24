class PasswordStrength {
  final double timeInSeconds;
  final String strength;
  //final List<String> suggestions;
  final Map<String, double> timesByAttackType;
  
  PasswordStrength({
    required this.timeInSeconds,
    required this.strength,
   // required this.suggestions,
    required this.timesByAttackType,
  });
  
  String get humanReadableTime {
    if (timeInSeconds < 60) {
      return '${timeInSeconds.toStringAsFixed(0)} sec';
    } else if (timeInSeconds < 3600) {
      return '${(timeInSeconds / 60).toStringAsFixed(1)} min';
    } else if (timeInSeconds < 86400) {
      return '${(timeInSeconds / 3600).toStringAsFixed(1)} hours';
    } else if (timeInSeconds < 31536000) {
      return '${(timeInSeconds / 86400).toStringAsFixed(1)} days';
    } else {
      return '${(timeInSeconds / 31536000).toStringAsFixed(1)} ages';
    }
  }
}