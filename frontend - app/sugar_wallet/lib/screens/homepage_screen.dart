import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_wallet/controller/user.dart';
import 'package:sugar_wallet/repository/api_call.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final city = TextEditingController();
  @override
  APICall repo = APICall();
  final AuthController controller = Get.find<AuthController>();
  bool isLoading = false;

  Future<void> getData() async {
    await repo.getData(city.value.text);
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    if (controller.city != null) city.text = controller.city ?? "";
    super.initState();
  }

  @override
  void dispose() {
    controller.city = null;
    controller.token = null;
    controller.data = [];
    super.dispose();
  }

  String dropdownValue = 'Online Order';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        controller.data = [];
        setState(() {
        });
        return false;
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xff91E5E7),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Image.asset("assets/images/sugar.png"),
              Expanded(
                child: controller.data.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text("Preferred Option")),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                fillColor: Colors.black,
                                labelStyle: const TextStyle(color: Colors.black),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DropdownButtonFormField(
                                    dropdownColor: const Color(0xff91E5E7),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    value: dropdownValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Dine In',
                                      'Takeaway',
                                      'Online Order'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Text("Enter City Name")),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: city,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                fillColor: Colors.black,
                                labelStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (city.value.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                await getData();
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 190,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            "Save And Get Deals",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Column(
                          children: [
                            for (int j = 0; j < controller.data.length; j++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.data[j]["storeName"]}",
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    border: TableBorder.all(
                                        color: Colors.black, width: 1.5),
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(5),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8),
                                            child: const Text(
                                              "Coupon",
                                              style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8),
                                            child: const Text(
                                              "Description",
                                              style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      for (int i = 0;
                                          i < controller.data[j]["data"].length;
                                          i++)
                                        TableRow(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 8.0, vertical: 8),
                                              child: Text(
                                                "${controller.data[j]["data"][i]["promo"]}",
                                                style: const TextStyle(
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 8.0, vertical: 8),
                                              child: Text(
                                                "${controller.data[0]["data"][i]["detail"]}",
                                                style: const TextStyle(
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  controller.city = null;
                  controller.token = null;
                  controller.data = [];
                  Navigator.pop(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
