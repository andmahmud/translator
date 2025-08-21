import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator_controller.dart';

class TranslatorScreen extends StatelessWidget {
  final TranslatorController controller = Get.put(TranslatorController());
  final TextEditingController inputController = TextEditingController();

  TranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Bangla To English Translator"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter Bangla or English text...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.translate(inputController.text, "bn", "en");
                    },
                    icon: Icon(Icons.translate),
                    label: Text("Bangla → English"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.translate(inputController.text, "en", "bn");
                    },
                    icon: Icon(Icons.translate),
                    label: Text("English → Bangla"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              controller.translatedText.value,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: controller.translatedText.value,
                                      ),
                                    );
                                    Get.snackbar(
                                      "Copied",
                                      "Text copied to clipboard",
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.volume_up,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    controller.speak();
                                  }, 
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
