class Reward {
  int id;
  String name;
  double price;
  String description;
  String image;
  DateTime releaseDate;
  DateTime deadline;

  Reward.mock(this.name, this.price, this.description, this.image, this.deadline);
}
