enum ExpMonth {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

String ExpMonthToString({required int index}) {
  switch (index) {
    case 0:
      return '1-January';
    case 1:
      return '2-February';
    case 2:
      return '3-March';
    case 3:
      return '4-April';
    case 4:
      return '5-May';
    case 5:
      return '6-June';
    case 6:
      return '7-July';
    case 7:
      return '8-August';
    case 8:
      return '9-September';
    case 9:
      return '10-October';
    case 10:
      return '11-November';
    case 11:
      return '12-December';

    default:
      return 'none';
  }
}
