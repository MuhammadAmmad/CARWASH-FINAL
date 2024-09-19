// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class CustomDropDown extends StatefulWidget {
//   final List<String> options;
//   final double width;
//   final double height;

//   const CustomDropDown({
//     Key? key,
//     required this.options,
//     this.width = 90.0,
//     this.height = 40.0,
//   }) : super(key: key);

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   late String dropdownValue;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.options.isNotEmpty) {
//       dropdownValue = widget.options.first;
//     } else {
//       dropdownValue = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       width: widget.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: kTertiaryColor, width: 2),
//         backgroundBlendMode: BlendMode.clear,
//         color: Color.fromRGBO(255, 255, 255, 0.00),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: dropdownValue,
//             icon: Icon(
//               Icons.arrow_drop_down,
//               color: kSecondaryColor,
//             ),
//             iconSize: 24,
//             dropdownColor: kBlackColor,
//             elevation: 16,
//             style: TextStyle(color: kSecondaryColor),
//             onChanged: (String? value) {
//               setState(() {
//                 dropdownValue = value!;
//               });
//             },
//             items: widget.options.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: TextStyle(color: kSecondaryColor),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomDropDown2 extends StatefulWidget {
//   final List<String> options;

//   final double height;

//   const CustomDropDown2({
//     Key? key,
//     required this.options,
//     this.height = 41.0,
//   }) : super(key: key);

//   @override
//   State<CustomDropDown2> createState() => _CustomDropDown2State();
// }

// class _CustomDropDown2State extends State<CustomDropDown2> {
//   late String dropdownValue;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.options.isNotEmpty) {
//       dropdownValue = widget.options.first;
//     } else {
//       dropdownValue = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(41),
//         border: Border.all(color: kTertiaryColor, width: 2),
//         color: Color.fromRGBO(255, 255, 255, 0.00),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: dropdownValue,
//             icon: Icon(
//               Icons.arrow_drop_down,
//               color: kSecondaryColor,
//             ),
//             iconSize: 24,
//             dropdownColor: kBlackColor,
//             elevation: 16,
//             style: TextStyle(color: kSecondaryColor),
//             onChanged: (String? value) {
//               setState(() {
//                 dropdownValue = value!;
//               });
//             },
//             items: widget.options.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: TextStyle(color: kSecondaryColor),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
