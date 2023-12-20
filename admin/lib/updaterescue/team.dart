class RescueTeam {
  String name;
  String leader;
  String type;
  String phone;
  String state;
  String district;

  RescueTeam(
      {required this.name,
      required this.leader,
      required this.type,
      required this.phone,
      required this.state,
      required this.district});

  @override
  String toString() {
    return 'Rescue Team: $name\nLeader: $leader\nType: $type \nPhone: $phone\nState: $state\nDistrict: $district';
  }
}
