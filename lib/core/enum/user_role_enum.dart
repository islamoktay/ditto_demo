enum UserRoleEnum {
  chief(title: 'Cabin Chief'),
  crew(title: 'Cabin Crew');

  const UserRoleEnum({required this.title});
  final String title;
}
