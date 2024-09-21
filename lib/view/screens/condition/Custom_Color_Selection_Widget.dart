import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:car_wash_light/controllers/light_controller.dart';
import 'dart:async';

class CustomColorSelection extends StatefulWidget {
  final String ledId;
  final VoidCallback onClose;

  CustomColorSelection({
    required this.ledId,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomColorSelection> createState() => _CustomColorSelectionState();
}

class _CustomColorSelectionState extends State<CustomColorSelection> {
  late Color currentColor;
  LightController lightController = Get.find();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    currentColor = Colors.blue; // Default color, you can change this
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _uploadColor();
    });
  }

  void _uploadColor() {
    String hexColor =
        '#${currentColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    print("Uploading color hex code: $hexColor");
    lightController.updateLEDColor(widget.ledId, hexColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Color for ${widget.ledId}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ColorPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
            colorPickerWidth: 300,
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false,
            displayThumbColor: true,
            paletteType: PaletteType.hueWheel,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Close'),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }
}
