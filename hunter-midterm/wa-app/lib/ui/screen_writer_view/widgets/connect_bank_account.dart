import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/network/models/create_bank_acocunt.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/utills/colors.dart';

class ConnnectBankAccount extends StatefulWidget {
  const ConnnectBankAccount({Key? key}) : super(key: key);

  @override
  _ConnnectBankAccountState createState() => _ConnnectBankAccountState();
}

class _ConnnectBankAccountState extends State<ConnnectBankAccount> {
  final Map<String, dynamic> _accountData = {
    "object": "bank_account",
    "country": "US",
    "currency": "usd",
    "account_holder_type": "individual",
    "routing_number": "110000000"
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: 400,
      height: 300,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Connect account",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Account holder name",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFields.withoutDecoration(
                  mapKey: 'account_holder_name',
                  errorMessage: 'Name required',
                  onSaved: _onSaved),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Account Numaber",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFields.withoutDecoration(
                  inputType: TextInputType.number,
                  mapKey: 'account_number',
                  errorMessage: 'Account number required',
                  onSaved: _onSaved),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        const Spacer(),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20)),
                            onPressed: () => Navigator.of(context).maybePop(),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: kRedColor, fontSize: 16),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20)),
                            onPressed: () async {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                CreateBankAccount? respo =
                                    await Provider.of<UserProvider>(context,
                                            listen: false)
                                        .connectBankAccount(_accountData);
                                if (respo != null) {
                                  ShowSnackBar.showSnackBar(
                                      context: context,
                                      title: "Account connected successfully");
                                  Navigator.of(context).maybePop();
                                } else {
                                  ShowSnackBar.showSnackBar(
                                      context: context,
                                      title:
                                          "Something went wrong, please try again.");
                                }

                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: const Text(
                              "Connect",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                            )),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  _onSaved(key, value) {
    _accountData[key] = value;
  }
}
