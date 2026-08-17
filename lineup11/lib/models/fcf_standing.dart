class FcfStanding {
  final int position;
  final String teamName;
  final String? logo;
  final String clubId;
  final String teamId;

  final double points;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;

  final List<dynamic> form;
  final int sanction;

  FcfStanding({
    required this.position,
    required this.teamName,
    required this.logo,
    required this.clubId,
    required this.teamId,
    required this.points,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.form,
    required this.sanction,
  });

  factory FcfStanding.fromJson(Map<String, dynamic> json) {
    final team = json['team'] ?? {};

    return FcfStanding(
      position: int.tryParse(json['position']?.toString() ?? '') ?? 0,
      teamName: team['name']?.toString() ?? '',
      logo: team['logo']?.toString(),
      clubId: team['clubId']?.toString() ?? '',
      teamId: team['teamId']?.toString() ?? '',
      points: double.tryParse(json['points']?.toString() ?? '') ?? 0,
      played: int.tryParse(json['played']?.toString() ?? '') ?? 0,
      won: int.tryParse(json['won']?.toString() ?? '') ?? 0,
      drawn: int.tryParse(json['drawn']?.toString() ?? '') ?? 0,
      lost: int.tryParse(json['lost']?.toString() ?? '') ?? 0,
      goalsFor: int.tryParse(json['goalsFor']?.toString() ?? '') ?? 0,
      goalsAgainst:
          int.tryParse(json['goalsAgainst']?.toString() ?? '') ?? 0,
      form: json['form'] is List ? json['form'] : [],
      sanction: int.tryParse(json['sanction']?.toString() ?? '') ?? 0,
    );
  }
}