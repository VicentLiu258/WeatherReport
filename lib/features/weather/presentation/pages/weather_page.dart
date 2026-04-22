import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int _selectedTab = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E225D),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A2A69), Color(0xFF3A2D6E), Color(0xFF5B1E54)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildTabPageView()),
              _buildBottomTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        if (!mounted || _selectedTab == index) {
          return;
        }
        setState(() => _selectedTab = index);
      },
      children: [
        _buildHomePage(),
        _buildCitySelectPage(),
        _buildDetailPage(),
        _buildLifestylePage(),
      ],
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          const SizedBox(height: 28),
          _buildCurrentWeather(),
          const SizedBox(height: 28),
          _buildHourlyForecast(),
          const SizedBox(height: 24),
          _buildDetailsGrid(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 20),
        const SizedBox(width: 6),
        const Text(
          'Aether',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30 / 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: Colors.white.withValues(alpha: 0.12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 20),
        ),
      ],
    );
  }

  Widget _buildCurrentWeather() {
    return Center(
      child: Column(
        children: [
          Text(
            'CURRENT LOCATION',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              letterSpacing: 1.8,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Reykjavik',
            style: TextStyle(
              color: Colors.white,
              fontSize: 46 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '2°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100 / 2,
                  fontWeight: FontWeight.w300,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.white.withValues(alpha: 0.95),
                  size: 46,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _MiniTempChip(label: '↑ 4°'),
              SizedBox(width: 10),
              _MiniTempChip(label: '↓ -1°'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Mainly Clear',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 32 / 2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Hourly Forecast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40 / 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              'Today',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 24 / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _HourlyCard(time: 'Now', temperature: '2°', icon: Icons.wb_sunny),
              SizedBox(width: 12),
              _HourlyCard(
                time: '14:00',
                temperature: '3°',
                icon: Icons.wb_sunny_outlined,
              ),
              SizedBox(width: 12),
              _HourlyCard(time: '15:00', temperature: '3°', icon: Icons.cloud),
              SizedBox(width: 12),
              _HourlyCard(
                time: '16:00',
                temperature: '1°',
                icon: Icons.cloudy_snowing,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsGrid() {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'WIND',
                value: '12 km/h',
                subtitle: 'From NW',
                icon: Icons.air,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _MetricCard(
                title: 'HUMIDITY',
                value: '78%',
                subtitle: 'High',
                icon: Icons.water_drop_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        _VisibilityCard(),
      ],
    );
  }

  Widget _buildBottomTabs() {
    const tabs = [
      'assets/icons/tab_dashboard.svg',
      'assets/icons/tab_search.svg',
      'assets/icons/tab_sun.svg',
      'assets/icons/tab_settings.svg',
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final selected = _selectedTab == index;
          return GestureDetector(
            onTap: () {
              if (_selectedTab == index) {
                return;
              }
              setState(() => _selectedTab = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    selected
                        ? Colors.white.withValues(alpha: 0.25)
                        : Colors.transparent,
              ),
              child: Center(
                child: SvgPicture.asset(
                  tabs[index],
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withValues(alpha: selected ? 0.98 : 0.65),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLifestylePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _LifestyleHeader(),
          SizedBox(height: 12),
          _LifestylePrimaryCard(),
          SizedBox(height: 10),
          _LifestyleStatCard(
            title: 'UV INDEX',
            value: 'Low',
            description: 'Low UV, no protection required for most.',
            icon: Icons.wb_sunny_outlined,
          ),
          SizedBox(height: 10),
          _LifestyleStatCard(
            title: 'AIR QUALITY',
            value: '42',
            description: 'Good. Air quality is considered satisfactory.',
            icon: Icons.air,
          ),
          SizedBox(height: 10),
          _LifestyleActivityCard(),
          SizedBox(height: 10),
          _LifestyleImageCard(),
          SizedBox(height: 10),
          _LifestyleTipsCard(),
        ],
      ),
    );
  }

  Widget _buildDetailPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailTopBar(),
          const SizedBox(height: 28),
          _buildDetailHeader(),
          const SizedBox(height: 22),
          _buildSevenDayForecastCard(),
          const SizedBox(height: 16),
          _buildDetailMetricRow(),
          const SizedBox(height: 12),
          _buildDetailMetricRowSecondary(),
          const SizedBox(height: 12),
          const _AirQualityCard(),
          const SizedBox(height: 12),
          const _SunriseSunsetCard(),
        ],
      ),
    );
  }

  Widget _buildDetailTopBar() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(
          'OSLO, NORWAY',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.86),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Aether',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  Widget _buildDetailHeader() {
    return Center(
      child: Column(
        children: [
          Text(
            'TODAY',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '12°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 66,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Mostly Clear',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 30 / 2,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _MiniTempChip(label: 'H: 14°'),
              SizedBox(width: 8),
              _MiniTempChip(label: 'L: 8°'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSevenDayForecastCard() {
    const rows = [
      _ForecastRowData(
        day: 'Today',
        icon: Icons.wb_sunny_outlined,
        rain: '0%',
        low: '8°',
        high: '14°',
        value: 0.66,
      ),
      _ForecastRowData(
        day: 'Tue',
        icon: Icons.cloud,
        rain: '15%',
        low: '7°',
        high: '12°',
        value: 0.58,
      ),
      _ForecastRowData(
        day: 'Wed',
        icon: Icons.grain,
        rain: '85%',
        low: '6°',
        high: '9°',
        value: 0.42,
      ),
      _ForecastRowData(
        day: 'Thu',
        icon: Icons.wb_cloudy_outlined,
        rain: '20%',
        low: '8°',
        high: '13°',
        value: 0.63,
      ),
      _ForecastRowData(
        day: 'Fri',
        icon: Icons.wb_sunny_outlined,
        rain: '0%',
        low: '9°',
        high: '16°',
        value: 0.74,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7-Day Forecast',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...rows.map((item) => _ForecastRow(item: item)),
        ],
      ),
    );
  }

  Widget _buildDetailMetricRow() {
    return const Row(
      children: [
        Expanded(
          child: _MetricCard(
            title: 'UV INDEX',
            value: '2',
            subtitle: 'Low',
            icon: Icons.wb_sunny_outlined,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            title: 'HUMIDITY',
            value: '64%',
            subtitle: 'The dew point is 7° right now.',
            icon: Icons.water_drop_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailMetricRowSecondary() {
    return const Row(
      children: [
        Expanded(
          child: _MetricCard(
            title: 'WIND',
            value: '12 km/h',
            subtitle: 'NW Gusts up to 18 km/h',
            icon: Icons.air,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            title: 'VISIBILITY',
            value: '10 km',
            subtitle: 'Clear view of the horizon',
            icon: Icons.visibility_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildCitySelectPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 26),
          Text(
            'SAVED LOCATIONS',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.54),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Manage Cities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36 / 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              _buildAddCityButton(),
            ],
          ),
          const SizedBox(height: 16),
          const _CityWeatherCard(
            city: 'New York',
            time: '12:45 PM',
            temperature: '72°',
            weather: 'CLEAR',
            humidity: '45%',
            wind: '12mph',
            highLow: 'H:78° L:64°',
            backgroundColors: [Color(0xFF42A9E9), Color(0xFF2A63B8)],
          ),
          const SizedBox(height: 14),
          const _CityWeatherCard(
            city: 'London',
            time: '5:45 PM',
            temperature: '58°',
            weather: 'STORM',
            humidity: '89%',
            wind: '24mph',
            highLow: 'H:62° L:55°',
            backgroundColors: [Color(0xFF2F4A6F), Color(0xFF111827)],
            isAlert: true,
          ),
          const SizedBox(height: 14),
          const _CityWeatherCard(
            city: 'Paris',
            time: '6:45 PM',
            temperature: '64°',
            weather: 'CLOUDY',
            humidity: '62%',
            wind: '8mph',
            highLow: 'H:68° L:59°',
            backgroundColors: [Color(0xFFA3A5AD), Color(0xFF5A6075)],
          ),
          const SizedBox(height: 16),
          _buildExploreCityButton(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(
            Icons.search,
            color: Colors.white.withValues(alpha: 0.54),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'Search for a city or airport',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 16 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCityButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'ADD CITY',
        style: TextStyle(
          color: Color(0xFF0A1228),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildExploreCityButton() {
    return Container(
      width: double.infinity,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              size: 16,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'EXPLORE NEW CITIES',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.58),
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniTempChip extends StatelessWidget {
  const _MiniTempChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.85),
          fontSize: 15 / 2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HourlyCard extends StatelessWidget {
  const _HourlyCard({
    required this.time,
    required this.temperature,
    required this.icon,
  });

  final String time;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Icon(icon, color: Colors.white.withValues(alpha: 0.95), size: 20),
          Text(
            temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.75), size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.68),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 12 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _VisibilityCard extends StatelessWidget {
  const _VisibilityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                color: Colors.white.withValues(alpha: 0.75),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'VISIBILITY',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.68),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                '10.2 km',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34 / 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Clear horizon',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.76),
                  fontSize: 16 / 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              minHeight: 3,
              value: 0.82,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withValues(alpha: 0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastRowData {
  const _ForecastRowData({
    required this.day,
    required this.icon,
    required this.rain,
    required this.low,
    required this.high,
    required this.value,
  });

  final String day;
  final IconData icon;
  final String rain;
  final String low;
  final String high;
  final double value;
}

class _ForecastRow extends StatelessWidget {
  const _ForecastRow({required this.item});

  final _ForecastRowData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              item.day,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(item.icon, color: Colors.white.withValues(alpha: 0.8), size: 16),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              item.rain,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 26,
            child: Text(
              item.low,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 4,
                value: item.value,
                backgroundColor: Colors.white.withValues(alpha: 0.14),
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFFBCB9FF).withValues(alpha: 0.95),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 30,
            child: Text(
              item.high,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AirQualityCard extends StatelessWidget {
  const _AirQualityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.air_outlined,
                color: Colors.white.withValues(alpha: 0.78),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'AIR QUALITY',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SAFE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '32 - Good',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Air quality is considered satisfactory, and air pollution poses little or no risk.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4EE26C),
                  Color(0xFFEFD24E),
                  Color(0xFFF68C45),
                  Color(0xFFEE5A5A),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 66,
                  top: -3,
                  child: Container(
                    width: 2,
                    height: 10,
                    color: Colors.white.withValues(alpha: 0.94),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SunriseSunsetCard extends StatelessWidget {
  const _SunriseSunsetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
            child: const Icon(
              Icons.wb_sunny_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildSunTime(title: 'SUNRISE', time: '06:12')),
                Expanded(child: _buildSunTime(title: 'SUNSET', time: '18:44')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTime({required String title, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.54),
            fontSize: 10,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21 / 2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CityWeatherCard extends StatelessWidget {
  const _CityWeatherCard({
    required this.city,
    required this.time,
    required this.temperature,
    required this.weather,
    required this.humidity,
    required this.wind,
    required this.highLow,
    required this.backgroundColors,
    this.isAlert = false,
  });

  final String city;
  final String time;
  final String temperature;
  final String weather;
  final String humidity;
  final String wind;
  final String highLow;
  final List<Color> backgroundColors;
  final bool isAlert;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 168,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: backgroundColors,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 16 / 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    temperature,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 66 / 2,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isAlert
                              ? const Color(0xFFB90F2E)
                              : Colors.white.withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      weather,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildMetaItem(Icons.water_drop_outlined, humidity),
              const SizedBox(width: 18),
              _buildMetaItem(Icons.air, wind),
              const Spacer(),
              Text(
                highLow,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16 / 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.88)),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.88),
            fontSize: 16 / 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LifestyleHeader extends StatelessWidget {
  const _LifestyleHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(
          'STOCKHOLM',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.84),
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Aether',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 16),
        ),
      ],
    );
  }
}

class _LifestylePrimaryCard extends StatelessWidget {
  const _LifestylePrimaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3 PERSONALIZED INSIGHTS',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.56),
              fontSize: 9,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Wear a light coat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The morning chill is lingering. A trench coat or a stylish denim jacket '
            'over a light knit will keep your look sharp and comfortable as you head out today.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13 / 2,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Icon(
              Icons.checkroom_outlined,
              size: 46,
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifestyleStatCard extends StatelessWidget {
  const _LifestyleStatCard({
    required this.title,
    required this.value,
    required this.description,
    required this.icon,
  });

  final String title;
  final String value;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.56),
                  fontSize: 9,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Icon(icon, size: 14, color: Colors.white.withValues(alpha: 0.8)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.76),
              fontSize: 11 / 2,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: 2.5,
              value: 0.42,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withValues(alpha: 0.64),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifestyleActivityCard extends StatelessWidget {
  const _LifestyleActivityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVITY',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.56),
              fontSize: 9,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ideal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Perfect for an afternoon jog or bike ride.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.77),
              fontSize: 12 / 2,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              _LifestyleTag(label: 'JOGGING'),
              SizedBox(width: 8),
              _LifestyleTag(label: 'BIKING'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LifestyleTag extends StatelessWidget {
  const _LifestyleTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 9,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _LifestyleImageCard extends StatelessWidget {
  const _LifestyleImageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              'https://images.unsplash.com/photo-1418065460487-3e41a6c84dc5?q=80&w=1200&auto=format&fit=crop',
              height: 108,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Optimal Running Window',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'The humidity will drop between 14:00 and 17:00. If you plan on jogging long run, this is your cooler window to peak performance and comfort.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.77),
              fontSize: 12 / 2,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _LifestyleTipsCard extends StatelessWidget {
  const _LifestyleTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'DAILY LIFESTYLE TIPS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 9,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          _LifestyleTipItem(
            icon: Icons.local_drink_outlined,
            title: 'Stay Hydrated',
            description:
                'Despite the cooler temps, the dry air can quickly deplete moisture. Carry a bottle and sip often.',
          ),
          SizedBox(height: 8),
          _LifestyleTipItem(
            icon: Icons.wb_twilight_outlined,
            title: 'Morning Light Exposure',
            description:
                'Clear skies until 11:00 can boost mood and help regulate your circadian rhythm.',
          ),
        ],
      ),
    );
  }
}

class _LifestyleTipItem extends StatelessWidget {
  const _LifestyleTipItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 13, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12 / 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.74),
                    fontSize: 11 / 2,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
