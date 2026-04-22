import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather({
    required String cityName,
  });
}
