import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_switch_menu.dart';
import 'package:fast_app_base/screen/opensource/s_opensource.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/data/preference/prefs.dart';
import '../../../../../common/widget/w_big_button.dart';
import 'd_number.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '설정'.text.make(),
      ),
      // 그리 많지 않기 때문에 builder 대신 children을 사용한다.
      body: ListView(
        children: [
          // setState를 사용하지 않고도 Obx를 사용하여 화면을 갱신한다. 
          // 일일히 setState로 Prefs의 값을 변경시키고 받아올 필요 없이 Obx를 사용하여 처리할 수 있다.
          Obx(
            () => SwitchMenu('푸시 설정', Prefs.isPushOnRx.get(), onChanged: (isOn) {
              Prefs.isPushOnRx.set(isOn);
            }),
          ),
          Obx(() => Slider(
              value: Prefs.sliderPosition.get(),
              onChanged: (value) {
                Prefs.sliderPosition.set(value);
              })),
          Obx(
            () => BigButton(
              '날짜 ${Prefs.birthday.get() == null ? "" : Prefs.birthday.get()?.formattedDate}',
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(90.days),
                    lastDate: DateTime.now().add(90.days));
                if (date != null) {
                  // GetX에서 바로 변경하여 따로 setState로 변경하지 않아도, Obs 내에서 UI가 갱신된다.
                  Prefs.birthday.set(date);
                }
              },
            ),
          ),
          Obx(
            () => BigButton(
              '저장된 숫자 ${Prefs.number.get()}',
              onTap: () async {
                final number = await NumberDialog().show();
                if (number != null) {
                  Prefs.number.set(number);
                }
              },
            ),
          ),
          BigButton(
            '오픈소스 화면',
            onTap: () async {
              Nav.push(const OpensourceScreen());
            },
          )
        ],
      ),
    );
  }
}
