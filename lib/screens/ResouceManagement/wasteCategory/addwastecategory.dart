import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwc/api/api_client.dart';
import 'package:zwc/api/urls.dart';
import 'package:zwc/controllers/resourcemanagemntcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:zwc/model/getstatusmodel.dart';
import 'package:zwc/screens/ResouceManagement/wasteCategory/wastecategoiry.dart';
import 'package:zwc/widgets/progressloader.dart';

import '../../../data/shared_preference.dart';

class AddWasteCategoryDetails extends StatefulWidget {
  AddWasteCategoryDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWasteCategoryDetails> createState() => _addwastedetailsState();
}

class _addwastedetailsState extends State<AddWasteCategoryDetails> {
  final ResourceManagementController rcontroller =
      Get.put(ResourceManagementController());

  String? categorynamehint = "Category Name";
  String? selectedparentcategory;
  String? selectedparentcategoryfinal;
  final TextEditingController categoirynamecontroller = TextEditingController();

  @override
  void initState() {
    getdashboardbranchid();
    rcontroller.getallwastecategorylist();

    super.initState();
  }

  String? dbbranchid;
  getdashboardbranchid() async {
    dbbranchid = await SharedPreferenceSingleTon.getData("dashboard_branch_id");
    return dbbranchid;
  }

  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  GetStatusModel? getuploadstatus;
  Future<GetStatusModel?> uploadImage(
      {String? file, categoryname, parentcategoryid}) async {
    var request = await http.MultipartRequest(
        'POST', Uri.parse(URLS.baseURL + URLS.addwastecategory));
    request.headers.addAll(APIClient.apiheaders);

    request.fields['category_name'] = categoryname;
    request.fields['parent_category'] = parentcategoryid;
    request.files.add(await http.MultipartFile.fromPath('file', file!));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    log(responsedData.toString());
    getuploadstatus = GetStatusModel.fromJson(responsedData);
    return getuploadstatus;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourceManagementController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Waste Category",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: controller.showloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Enter Category Name",
                        style: GoogleFonts.roboto(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: categoirynamecontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: categorynamehint,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          child: Center(
                        child: DropdownButton(
                          value: selectedparentcategory,
                          underline: SizedBox(),
                          style: GoogleFonts.roboto(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          hint: Text(
                            "Select Parent Category",
                            style: GoogleFonts.roboto(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          items: controller.getallwastecategoeydata!.data!
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item.categoryName}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${item.id}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.transparent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedparentcategory = value.toString();
                              selectedparentcategoryfinal = controller
                                  .getallwastecategoeydata!.data!
                                  .where((element) =>
                                      element.id.toString() == value.toString())
                                  .first
                                  .parentCategory
                                  .toString();
                            });
                            log(value.toString());
                          },
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          _pickImage();
                        },
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select Category Image",
                                    style: GoogleFonts.roboto(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_imageFile != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Image.file(
                              _imageFile!,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (categoirynamecontroller.text.isNotEmpty &&
                                  selectedparentcategoryfinal != null) {
                                if (_imageFile != null) {
                                  Progressloaders.progressloaderdailog(context);
                                  uploadImage(
                                          file: _imageFile!.path.toString(),
                                          categoryname: categoirynamecontroller
                                              .text
                                              .toString(),
                                          parentcategoryid:
                                              selectedparentcategoryfinal
                                                  .toString())
                                      .then((value) => {
                                            if (value!.status.toString() ==
                                                "true")
                                              {
                                                Get.back(),
                                                Get.snackbar("Waste Category",
                                                    "Category Added!",
                                                    backgroundColor:
                                                        Colors.blue,
                                                    colorText: Colors.white,
                                                    borderColor: Colors.white,
                                                    borderWidth: 1),
                                                categoirynamecontroller.clear(),
                                                Get.deleteAll(),
                                                Get.to(Getwastecategorydata())
                                              }
                                            else
                                              {
                                                Get.back(),
                                                Get.snackbar("Waste Category",
                                                    "Category Not Added!",
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    borderColor: Colors.white,
                                                    borderWidth: 1),
                                              }
                                          });
                                } else {
                                  Get.snackbar("Waste Category",
                                      "Please Select Category Image",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      borderColor: Colors.white,
                                      borderWidth: 1);
                                }
                              } else {
                                Get.snackbar("Waste Category",
                                    "Please Enter Category Name or select parent category",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    borderWidth: 1);
                              }
                            },
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
