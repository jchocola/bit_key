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
      return '2-January';
    case 2:
      return '3-January';
    case 3:
      return '4-January';
    case 4:
      return '5-January';
    case 5:
      return '6-January';
    case 6:
      return '7-January';
    case 7:
      return '8-January';
    case 8:
      return '9-January';
    case 9:
      return '10-January';
    case 10:
      return '11-January';
    case 11:
      return '12-January';

    default:
      return 'none';
  }
}
