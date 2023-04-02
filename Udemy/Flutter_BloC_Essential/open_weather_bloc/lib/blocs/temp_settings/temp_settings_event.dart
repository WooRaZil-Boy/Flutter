part of 'temp_settings_bloc.dart';

abstract class TempSettingsEvent extends Equatable {
  const TempSettingsEvent();

  @override
  List<Object> get props => [];
}

// 해당 이벤트는 weather와 달리 현재 값을 반대로 바꾸기만 하면 되므로 추가적인 정보가 필요없다.
class ToggleTempUnitEvent extends TempSettingsEvent {}