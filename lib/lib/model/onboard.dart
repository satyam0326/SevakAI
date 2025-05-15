class Onboard {
  final String title;
  final String subtitle;
  final String lottie;
  final double lottieHeight; // Add this new property

  Onboard({
    required this.title,
    required this.subtitle,
    required this.lottie,
    this.lottieHeight = 0.5, // Default value of 0.5
  });
}
