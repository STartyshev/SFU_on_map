class Coordinates {
  final double lat;
  final double long;

  const Coordinates({
    required this.lat,
    required this.long,
  });
}

class StudCityCoordinates extends Coordinates {
  const StudCityCoordinates({
    super.lat = 55.997478,
    super.long = 92.795822,
  });
}

class KrasnoyarskCoordinates extends Coordinates {
  const KrasnoyarskCoordinates({
    super.lat = 56.0184,
    super.long = 92.8672
  });
}