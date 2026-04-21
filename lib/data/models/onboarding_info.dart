class OnboardingInfo {
  final String title;
  final String description;
  final String? imageAsset; // Using null if we are mimicking the card with Flutter code
  final String? imageAsset1; // Using null if we are mimicking the card with Flutter code

  OnboardingInfo({
    required this.title,
    required this.description,
    this.imageAsset,
    this.imageAsset1,
  });
}
