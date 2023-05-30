part of 'published_units_cubit.dart';

class PublishedUnitsState {
  final List<Unit> _units;
  final String request;

  PublishedUnitsState({
    List<Unit> units = const [],
    this.request = '',
  }) : _units = units;

  List<Unit> get units => List<Unit>.from(
        _units.where(
          (unit) => unit.name.contains(request),
        ),
      );

  PublishedUnitsState copyWith({
    List<Unit>? newUnits,
    String? newRequest,
  }) =>
      PublishedUnitsState(
        units: newUnits ?? _units,
        request: newRequest ?? request,
      );
}
