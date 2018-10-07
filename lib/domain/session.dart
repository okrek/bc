
class Sessions {

  List<DateTime> bookingDates;
  List<DateTime> workingDates;

  Sessions(this.bookingDates, this.workingDates);

  Sessions.fromJson(Map<String, dynamic> json) {

    bookingDates = (json['booking_dates'] as List).map((value) => DateTime.parse(value)).toList();
    workingDates = (json['working_dates'] as List).map((value) => DateTime.parse(value)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_dates'] = this.bookingDates;
    data['working_dates'] = this.workingDates;
    return data;
  }
}