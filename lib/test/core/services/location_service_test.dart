// location_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/location_service.dart';

// Mock classes
class MockGeolocatorPlatform extends Mock implements GeolocatorPlatform {}

class MockLogger extends Mock implements Logger {}

void main() {
  late LocationService locationService;
  late MockGeolocatorPlatform mockGeolocatorPlatform;
  late MockLogger mockLogger;

  setUp(() {
    mockGeolocatorPlatform = MockGeolocatorPlatform();
    mockLogger = MockLogger();
    // Set the mock as the platform instance for testing
    GeolocatorPlatform.instance = mockGeolocatorPlatform;
    locationService = LocationService(mockLogger);

    // Stub logger methods
    when(() => mockLogger.i(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.w(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.e(any<dynamic>())).thenReturn(null);
  });

  group('LocationService', () {
    test(
      'getCurrentLocation returns position if services enabled and permissions granted',
      () async {
        when(
          () => mockGeolocatorPlatform.isLocationServiceEnabled(),
        ).thenAnswer((_) async => true);
        when(
          () => mockGeolocatorPlatform.checkPermission(),
        ).thenAnswer((_) async => LocationPermission.always);
        when(
          () => mockGeolocatorPlatform.getCurrentPosition(
            locationSettings: any(named: 'locationSettings'),
          ),
        ).thenAnswer(
          (_) async => Position(
            latitude: 1.0,
            longitude: 2.0,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            floor: null,
            isMocked: false,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
          ),
        );

        final position = await locationService.getCurrentLocation();
        expect(position, isNotNull);
        expect(position!.latitude, 1.0);
        expect(position.longitude, 2.0);
      },
    );

    test(
      'getCurrentLocation returns null if location services are disabled',
      () async {
        when(
          () => mockGeolocatorPlatform.isLocationServiceEnabled(),
        ).thenAnswer((_) async => false);

        final position = await locationService.getCurrentLocation();
        expect(position, isNull);
        verify(() => mockLogger.w(any<dynamic>())).called(1);
      },
    );

    test('getCurrentLocation returns null if permissions are denied', () async {
      when(
        () => mockGeolocatorPlatform.isLocationServiceEnabled(),
      ).thenAnswer((_) async => true);
      when(
        () => mockGeolocatorPlatform.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.denied);
      when(
        () => mockGeolocatorPlatform.requestPermission(),
      ).thenAnswer((_) async => LocationPermission.denied);

      final position = await locationService.getCurrentLocation();
      expect(position, isNull);
      verify(() => mockLogger.w(any<dynamic>())).called(1);
    });

    test(
      'getCurrentLocation returns null if permissions are denied forever',
      () async {
        when(
          () => mockGeolocatorPlatform.isLocationServiceEnabled(),
        ).thenAnswer((_) async => true);
        when(
          () => mockGeolocatorPlatform.checkPermission(),
        ).thenAnswer((_) async => LocationPermission.deniedForever);

        final position = await locationService.getCurrentLocation();
        expect(position, isNull);
        verify(() => mockLogger.w(any<dynamic>())).called(1);
      },
    );

    test(
      'getCurrentLocation returns null and logs error on exception',
      () async {
        when(
          () => mockGeolocatorPlatform.isLocationServiceEnabled(),
        ).thenAnswer((_) async => true);
        when(
          () => mockGeolocatorPlatform.checkPermission(),
        ).thenAnswer((_) async => LocationPermission.always);
        when(
          () => mockGeolocatorPlatform.getCurrentPosition(
            locationSettings: any(named: 'locationSettings'),
          ),
        ).thenThrow(Exception('GPS error'));

        final position = await locationService.getCurrentLocation();
        expect(position, isNull);
        verify(() => mockLogger.e(any<dynamic>())).called(1);
      },
    );
  });
}
