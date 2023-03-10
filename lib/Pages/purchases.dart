import 'package:flutter/material.dart';
import '../widgets/onepurchase.dart';
import 'dart:math';

// import '../widgets/addpurchase.dart';

String image = "assets/edible.png";
String price = "1\$";

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    // Getting the height and width of the screen

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(left: width - width / 1.7),
          child: ClipPath(
              clipper: MyClipPath(),
              child: Container(
                color: const Color.fromRGBO(255, 180, 0, 1),
                height: height,
                width: width / 1.7,
              )),
        ),
        Center(
            child: Container(
          height: height - 180,
          width: width - 200,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
          child: Column(
            children: [
              const Text("PURCHASES",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.amber,
                      fontFamily: "Arial")),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Icon(
                      Icons.add,
                      size: 30.0,
                      color: Color.fromRGBO(255, 180, 0, 1),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const AddPurchase(
                          // onClickedDone: addPurchase,
                          ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: SizedBox.expand(
                  child: PaginatedDataTable(
                    columns: const [
                      DataColumn(label: Text('NUMBER')),
                      DataColumn(label: Text('NAME')),
                      DataColumn(label: Text('PRICE')),
                      DataColumn(label: Text('PURCHASE DATE')),
                      DataColumn(label: Text('EDIT')),
                    ],
                    source: _data,
                    // columnSpacing: 100,
                    horizontalMargin: 40,
                    rowsPerPage: 5,
                  ),
                ),
                // )
                //   ],
                // ),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index + 1,
            "title": "Item $index",
            "price": Random().nextInt(10000),

            "date_created": index,
            // Cater for the index during the deletion
            "edit": index,
          });
  @override
  DataRow? getRow(int index) {
    // MyData implement getRow
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['title'])),
      DataCell(Text(_data[index]['price'].toString())),
      DataCell(Text(_data[index]['date_created'].toString())),
      DataCell(buildEditButton()),
    ]);
  }

  @override
  // MyData implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // MyData implement rowCount
  int get rowCount => _data.length;

  @override
  // MyData: implement selectedRowCount
  int get selectedRowCount => 0;
  Widget buildEditButton() {
    return TextButton(
      child: const Text("Edit"),
      onPressed: () {},
    );
  }
}

class MyClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    var ctrl1 = Offset(size.width / 18, 2.7 / 4 * size.height);
    var ctrl2 = Offset(size.width / 2.5, size.height / 2);
    path.quadraticBezierTo(ctrl1.dx, ctrl1.dy, ctrl2.dx, ctrl2.dy);
    var ctrl3 = Offset(2.6 / 4 * size.width, size.height / 2.4);
    var ctrl4 = Offset(size.width, 0);
    path.quadraticBezierTo(ctrl3.dx, ctrl3.dy, ctrl4.dx, ctrl4.dy);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
