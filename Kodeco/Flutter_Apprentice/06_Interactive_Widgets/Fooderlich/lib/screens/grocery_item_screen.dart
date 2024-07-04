import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../components/grocery_tile.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null);

  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  // initState()는 사용하기 전에 해당 프로퍼티를 초기화합니다.
  @override
  void initState() {
    super.initState();

    // originalItem이 null이 아닌 경우 사용자는 기존 항목을 편집하고 있는 것입니다.
    // 이 경우 항목의 값을 표시하도록 위젯을 구성해야 합니다.
    final originalItem = widget.originalItem;
    if(originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute,);
      _dueDate = date;
    }

    // 텍스트 필드 변경을 수신하는 리스너를 추가합니다. 텍스트가 변경되면 _name을 설정합니다.
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 버튼이 있는 앱 바를 포함합니다. 사용자는 항목 생성을 완료하면 이 버튼을 탭합니다.
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // 사용자가 Save을 탭하면 모든 상태 속성을 가져와 GroceryItem을 생성합니다.
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                // 사용자가 기존 항목을 업데이트하는 경우 onUpdate를 호출합니다.
                widget.onUpdate(groceryItem);
              } else {
                // 사용자가 새 항목을 생성하는 경우 onCreate를 호출합니다.
                widget.onCreate(groceryItem);
              }
            },
          )
        ],
        // elevation를 0.0으로 설정하여 앱 바 아래의 그림자를 제거합니다.
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600)
        ),
      ),
      body: Container(
        // 모든 면에 16px씩 padding된 ListView를 표시합니다
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10.0),
            buildColorPicker(context),
            const SizedBox(height: 10.0),
            buildQuantityField(),
            GroceryTile(
              item: GroceryItem(
                id: 'previewMode',
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      // Column의 모든 위젯을 왼쪽에 정렬합니다.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // 항목의 이름을 입력할 TextField를 추가합니다.
        TextField(
          // TextField의 TextEditingController를 설정합니다.
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor)
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor)
            )
          ),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          // Wrap을 추가하고 각 자식 위젯을 10픽셀 간격으로 배치합니다.
          spacing: 10.0,
          children: [
            // 사용자가 low 우선순위를 선택할 수 있도록 ChoiceChip을 생성합니다.
            ChoiceChip(
              // 선택한 칩의 배경색을 검정색으로 설정합니다.
              selectedColor: Colors.black,
              // 사용자가 이 ChoiceChip을 선택했는지 확인합니다.
              selected: _importance == Importance.low,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              // 사용자가 이 칩을 선택했다면 _importance를 업데이트합니다.
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            )
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    // Column을 추가하여 요소를 세로로 배치합니다.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row을 추가하여 요소를 가로로 배치합니다.
        Row(
          // 행의 요소 사이에 공백을 추가합니다.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            // 선택한 값을 확인하는 TextButton을 추가합니다.
            TextButton(
              child: const Text('Select'),
              // 사용자가 버튼을 누를 때 현재 날짜를 가져옵니다.
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  // 오늘부터 향후 5년까지의 날짜만 선택할 수 있도록 합니다.
                  lastDate: DateTime(currentDate.year + 5),
                );
                // 사용자가 날짜를 선택한 후 _dueDate를 설정합니다.
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        // 현재 날짜의 서식을 지정합니다.
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  // 초기 시간을 현재 시간으로 설정합니다.
                  initialTime: TimeOfDay.now()
                );

                // 사용자가 위젯을 선택하면 _timeOfDay가 업데이트됩니다.
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              }
            )
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    // Row 위젯을 추가하여 ColorPicker 섹션을 가로 방향으로 레이아웃합니다.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 하위 `Row`을 생성하고 다음 위젯을 그룹화합니다:
        //     - 선택한 색상을 표시하는 `Container`.
        //     - 8픽셀 너비의 `SizedBox`.
        //     - ColorPicker의 제목을 표시할 `Text`.
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            )
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            // 버튼을 탭하면 팝업 대화 상자를 표시합니다.
            showDialog(
              context: context,
              builder: (context) {
                // BlockPicker를 AlertDialog 안에 감쌉니다.
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    // 사용자가 색상을 선택하면 _currentColor를 업데이트합니다.
                    onColorChanged: (color) {
                      setState(() => _currentColor = color);
                    },
                  ),
                  actions: [
                    // 대화 상자에 액션 버튼을 추가합니다. 사용자가 Save을 탭하면 dialog를 닫습니다.
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                    )
                  ],
                );
              }
            );
          }
        )
      ],
    );
  }

  Widget buildQuantityField() {
    // Column을 사용하여 위젯을 세로로 배치합니다.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 두 개의 Text를 포함하는 Row을 생성하여 수량 섹션에 제목과 수량 레이블을 추가합니다.
        // SizedBox를 사용하여 Text를 구분합니다.
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0)
            ),
            const SizedBox(width: 16.0),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0)
            )
          ],
        ),
        Slider(
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          value: _currentSliderValue.toDouble(),
          // 슬라이더의 최소값과 최대값을 설정합니다.
          min: 0.0,
          max: 100.0,
          // 슬라이더의 증가 방법을 설정합니다.
          divisions: 100,
          // 슬라이더 위에 레이블을 설정합니다. 여기서는 슬라이더 위에 현재 값을 표시하려고 합니다.
          label: _currentSliderValue.toInt().toString(),
          // 값이 변경되면 _currentSliderValue를 업데이트합니다.
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
        )
      ],
    );
  }
}



