import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Weather> getCurrentWeather({required String cityName}) async {
    // Placeholder: later replace with real API integration.
    return Weather(
      cityName: cityName,
      temperatureCelsius: 0,
      description: 'Unknown',
    );
  }
}
