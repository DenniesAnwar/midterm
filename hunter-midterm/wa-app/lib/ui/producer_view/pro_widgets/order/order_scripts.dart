import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/models/order_response.dart';
import 'package:wa_app/providers/order_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';

class OrderScripts extends StatefulWidget {
  const OrderScripts({Key? key}) : super(key: key);

  @override
  _OrderScriptsState createState() => _OrderScriptsState();
}

class _OrderScriptsState extends State<OrderScripts> {
  final ScrollController _ordersController = ScrollController();
  bool _isLoading = true;
  late OrderProvider _orderProvider;
  OrderResponse? _orderResponse;
  @override
  void initState() {
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    Future.microtask(() async {
      _orderResponse = await _orderProvider.getOrders();
      if (_orderResponse != null) {
        setState(() {
          _isLoading = false;
        });
      } else {
        ShowSnackBar.showSnackBar(
            context: context, title: "Something went wrong, please try again");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loadingWidget()
        : ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: _ordersController,
              child: Wrap(
                children: [
                  ...List.generate(_orderResponse!.orderData!.length, (index) {
                    OrderData model = _orderResponse!.orderData![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 31.0),
                      child: ScriptDocument(
                        scriptDataModel: model.dataModel!,
                        isOrderScript: true,
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
  }
}
