import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/product_details_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/models/product_details_model.dart';
import 'package:cashew_cart/models/trending_product_model.dart';
import 'package:cashew_cart/presentation/authentication/signin_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/shop/shop_screen.dart';
import 'package:cashew_cart/presentation/widgets/add_or_edit_address.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Services {
  AppController controller = Get.put(AppController());
  ProfileController profileController = Get.put(ProfileController());
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: CustomTextWidget(
        text: message,
        fontColor: Colors.white,
      ),
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      duration: Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAddressEditBottomSheet(bool addNewAddress, BuildContext context, String id, String heading, String buttonLabel, TextEditingController nameController, TextEditingController cityController,
      TextEditingController addressController, TextEditingController postalcodeController, TextEditingController phoneNumberController) {
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    heading,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  AddOrEditAddress(
                    nameController: nameController,
                    cityController: cityController,
                    addressController: addressController,
                    postalcodeController: postalcodeController,
                    phoneNumberController: phoneNumberController,
                    state: profileController.state,
                    district: profileController.district,
                    formKey: formKey,
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        final response;
                        if (nameController.text.trim() != "" &&
                            cityController.text.trim() != "" &&
                            addressController.text.trim() != "" &&
                            profileController.district != null &&
                            profileController.state != null &&
                            postalcodeController.text.trim() != "" &&
                            phoneNumberController.text.trim() != "") {
                          if (addNewAddress) {
                            response = await ApiServices().createUserAddress(
                              context,
                              nameController.text,
                              cityController.text,
                              addressController.text,
                              profileController.district!,
                              profileController.state!,
                              postalcodeController.text,
                              phoneNumberController.text,
                              false,
                            );
                          } else {
                            response = await ApiServices().editUserAddress(
                              context,
                              id,
                              nameController.text,
                              cityController.text,
                              addressController.text,
                              profileController.district!,
                              profileController.state!,
                              postalcodeController.text,
                              phoneNumberController.text,
                              false,
                            );
                          }

                          if (response != null) {
                            showCustomSnackBar(
                              context,
                              addNewAddress ? "Address added successfully" : "Address edited successfully",
                            );

                            profileController.getUserAddresses();
                            Navigator.pop(context);
                          }
                        } else {
                          showWarning(context, "Please fill all fields");
                          //  showCustomSnackBar(
                          //       context,
                          //       "Please fill all fields",
                          //     );
                        }
                      }
                    },
                    child: CustomElevatedButton(
                      label: buttonLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showLoginAlert(BuildContext context, String description) async {
    await Alert(
      context: context,
      type: AlertType.warning,
      title: "NO ACCESS",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Get.to(() => SignInScreen()),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0),
            ],
          ),
        )
      ],
      closeFunction: () => Navigator.of(context, rootNavigator: true).pop(),
    ).show();
  }

  showWarning(BuildContext context, String description) async {
    await Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
      closeFunction: () => Navigator.of(context, rootNavigator: true).pop(),
    ).show();
  }

  getProductDetailsAndGotoShopScreen(BuildContext context, String productId) async {
    context.loaderOverlay.show();
    final ProductDetailsModel productDetails = await productDetailsController.getProductDetails(productId);
    final Random _random = Random();
    int randomIndex;
    randomIndex = _random.nextInt(3);
    context.loaderOverlay.hide();

    print("rand index ======================= $randomIndex");
    // when using cupertino tabbar view for bottomnavbar, if we want persistent navbar then need to use navigatior instead of get.to
    final List<TrendingProductModel> randomProductList;

    switch (randomIndex) {
      case 0:
        randomProductList = controller.trending;
        break;
      case 1:
        randomProductList = controller.sponserd;
        break;
      case 2:
        randomProductList = controller.bestSellers;
        break;
      default:
        randomProductList = controller.bestSellers;
    }
    print("Random number \n::::\n:::\n:: $randomIndex");
    controller.getSimilarProducts(productDetails.name, productDetails.category.parentName);
    productDetailsController.getProductReviews(productId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShopScreen(
          randomIndex: randomIndex,
          randomProductList: randomProductList,
          productDetails: productDetails,
        ),
      ),
    );

    // controller.productDetailsList.add(controller.productDetails.value!);

    // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
    // bottomNavbarIndexNotifier.value = 4;
  }

  Future<void> savePDF(String pdfPath) async {
    File pdfFile = File(pdfPath);
    print("Trying to save PDF from path: $pdfPath");

    if (!await pdfFile.exists()) {
      print("PDF file does not exist at path: $pdfPath");
      return;
    }

    String? savedPath = await savePDFToUserSelectedFolder(pdfPath);

    if (savedPath != null) {
      print("PDF saved successfully at: $savedPath");
      await showNotification("Download Complete", "Invoice is saved", savedPath);
    } else {
      print("Failed to save PDF");
    }

    // Delete the temporary file only if it exists
    if (await pdfFile.exists()) {
      await pdfFile.delete();
      print("Temporary file deleted");
    }
  }

  Future<String?> savePDFToUserSelectedFolder(String pdfPath) async {
    try {
      // Check and request permissions
      bool hasPermission = await checkAndRequestPermissions();
      if (!hasPermission) {
        print("Permission denied");
        return null;
      }

      final pdfFile = File(pdfPath);
      String currentFileName = path.basename(pdfFile.path);
      Uint8List fileBytes = await pdfFile.readAsBytes();

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      // For Android 10 (API 29) and above, use SAF to let the user choose the directory
      if (androidInfo.version.sdkInt >= 29) {
        print("Android version 10 or above");
        String fileName = '${currentFileName}_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final result = await FilePicker.platform.saveFile(
          fileName: fileName,
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          bytes: fileBytes,
        );

        print("File saved at $result");
        return result;
      }
      // For Android 9 and below, use traditional file access
      else {
        String? externalStoragePath = await AndroidPathProvider.downloadsPath;
        String initialDir = '$externalStoragePath/PDF Editor';

        // Ensure the initial directory exists
        await Directory(initialDir).create(recursive: true);

        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
          initialDirectory: initialDir,
        );

        if (selectedDirectory == null) {
          print("No directory selected");
          return null;
        }

        String fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
        String savePath = '$selectedDirectory/$fileName';
        print("Saving to path: $savePath");

        await pdfFile.copy(savePath);
        return savePath;
      }
    } catch (e) {
      print("Error saving PDF: $e");
      return null;
    }
  }

  Future<bool> checkAndRequestPermissions() async {
    print("Checking for permission");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt < 29) {
      PermissionStatus status = await Permission.storage.status;
      if (!status.isGranted) {
        print("Permission not granted. Requesting for permission");
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } else if (androidInfo.version.sdkInt >= 30) {
      if (!await Permission.manageExternalStorage.isGranted) {
        print("Requesting MANAGE_EXTERNAL_STORAGE permission");
        PermissionStatus status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          print("MANAGE_EXTERNAL_STORAGE permission denied");
          return false;
        }
      }
      return true;
    }
    return true;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String title, String body, String filePath) async {
    print("File path for opening :$filePath");
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: filePath,
    );
  }
}
