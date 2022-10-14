import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/dialog_boxs/purchase_script_package_dialog.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_side_menu.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';

class ProducerViewMainScreen extends StatefulWidget {
  const ProducerViewMainScreen({Key? key}) : super(key: key);

  @override
  _ProducerViewMainScreenState createState() => _ProducerViewMainScreenState();
}

class _ProducerViewMainScreenState extends State<ProducerViewMainScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = true;

  @override
  void initState() {
    Future.microtask(() async {
      Provider.of<ProducerProvider>(context,listen: false).isProducer=true;
      await Helpers.getUserData(context);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showPurchaseScriptPackageDialog(context,_formKey);
          },
        ),
        backgroundColor: Colors.white,
        body: _isLoading?Center(child: loadingWidget(),):Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProducerSideMenu(),
            Expanded(
              child: Consumer<ProducerProvider>(
                builder: (_, dashProvider, __) {
                  return dashProvider.activeWidget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}


