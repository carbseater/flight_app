class Flight {
  final String source;
  final String dest;
  final String time;
  final String name;
  final String date;
  final String seats;
  final String fare;

  const Flight({
    required this.source,
    required this.dest,
    required this.time,
    required this.name,
    required this.date,
    required this.seats,
    required this.fare
  });

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    time: json['time'],
    name: json['name'],
    source: json['source'],
    dest: json['dest'],
    date: json['date'],
    seats: json['seats'],
    fare: json['fare']
  );

  Map<String, dynamic> toJson() => {
    'time': time,
    'name': name,
    'source':source,
    'dest':dest,
    'date':date,
    'fare':fare,
    'seats':seats
  };
}
