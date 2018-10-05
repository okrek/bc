class Barber {
  String id;
  String name;
  bool bookable;
  String specialization;
  String showRating;
  String rating;
  String votesCount;
  String avatar;
  String commentsCount;
  String weight;
  String information;
  String seanceDate;
  List<Seances> seances;

  Barber(
      {this.id,
        this.name,
        this.bookable,
        this.specialization,
        this.showRating,
        this.rating,
        this.votesCount,
        this.avatar,
        this.commentsCount,
        this.weight,
        this.information,
        this.seanceDate,
        this.seances});

  Barber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bookable = json['bookable'];
    specialization = json['specialization'];
    showRating = json['show_rating'];
    rating = json['rating'];
    votesCount = json['votes_count'];
    avatar = json['avatar'];
    commentsCount = json['comments_count'];
    weight = json['weight'];
    information = json['information'];
    seanceDate = json['seance_date'];
    if (json['seances'] != null) {
      seances = new List<Seances>();
      json['seances'].forEach((v) {
        seances.add(new Seances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bookable'] = this.bookable;
    data['specialization'] = this.specialization;
    data['show_rating'] = this.showRating;
    data['rating'] = this.rating;
    data['votes_count'] = this.votesCount;
    data['avatar'] = this.avatar;
    data['comments_count'] = this.commentsCount;
    data['weight'] = this.weight;
    data['information'] = this.information;
    data['seance_date'] = this.seanceDate;
    if (this.seances != null) {
      data['seances'] = this.seances.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Seances {
  String time;
  int seanceLength;
  String datetime;

  Seances({this.time, this.seanceLength, this.datetime});

  Seances.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    seanceLength = json['seance_length'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['seance_length'] = this.seanceLength;
    data['datetime'] = this.datetime;
    return data;
  }
}