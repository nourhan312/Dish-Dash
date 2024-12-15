class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Cook, Click, and Create!",
    image: "assets/images/image1.jpg",
    desc: "Taste the World, One Recipe at a Time!",
  ),
  OnboardingContents(
    title: "Your Kitchen Companion!",
    image: "assets/images/image2.jpg",
    desc: "Discover Deliciousness Daily! From Pantry to Plate!",
  ),
  OnboardingContents(
    title: "Get notified when work happens",
    image: "assets/images/image3.jpg",
    desc: "Whisking Up Wonders! Cook Smarter, Not Harder!",
  ),
];
