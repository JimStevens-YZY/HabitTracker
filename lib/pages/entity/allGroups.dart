class AllGroups {
  AllGroups({
    required this.groupBg,
    required this.groupDesc,
    required this.groupLocation,
    required this.groupName,
    required this.groupOrganizers,
    required this.groupType,
  });

  final String groupBg;
  final String groupDesc;
  final String groupLocation;
  final String groupName;
  final List<dynamic> groupOrganizers;
  final int groupType;
}
