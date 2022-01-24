class Films {
  final String? name, description, launchOn, bannerPath, posterPath;
  final int? movieId;
  bool isActorsNeed = false;

  Films({
    this.movieId,
    this.description,
    this.bannerPath,
    this.posterPath,
    this.launchOn,
    this.name,
  });

  factory Films.fromJson(Map<String, dynamic> json) {
    final name = json['title'];
    final movieId = json['id'];
    final launchOn = json['release_date'];
    final description = json['overview'];
    final bannerPath = json['backdrop_path'];
    final posterPath = json['poster_path'];
    return Films(
      name: name,
      movieId: movieId,
      launchOn: launchOn,
      description: description,
      bannerPath: bannerPath,
      posterPath: posterPath,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['movieId'] = movieId;
    data['launchOn'] = launchOn;
    data['description'] = description;
    data['bannerPath'] = bannerPath;
    data['posterPath'] = posterPath;
    return data;
  }
}
