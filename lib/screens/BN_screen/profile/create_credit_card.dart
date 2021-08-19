import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nova_ecommerce/getx/card_getx_controller.dart';
import 'package:nova_ecommerce/models/card.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/card_text_field.dart';
import 'package:nova_ecommerce/utils/helper.dart';
import 'package:nova_ecommerce/utils/my_card_widget.dart';


class CreateCreditCard extends StatefulWidget {
  const CreateCreditCard({Key? key}) : super(key: key);

  @override
  _CreateCreditCardState createState() => _CreateCreditCardState();
}

class _CreateCreditCardState extends State<CreateCreditCard> {
  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cvvCode;
  bool flag = false;
  bool isVisa = true;
  DateTime? _pickedDateValue;
  String? _pickedDate;
  late TextEditingController numberEditingController;
  late TextEditingController dateEditingController;
  late TextEditingController cvvEditingController;
  late TextEditingController holderNameEditingController;

  @override
  void initState() {
    numberEditingController = TextEditingController();
    dateEditingController = TextEditingController();
    cvvEditingController = TextEditingController();
    holderNameEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              MyCardWidget(
                cardNumber: cardNumber,
                cardType: isVisa ? CardType.visa : CardType.mastercard,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                expiryDate: expiryDate,
                flag: flag,
              ),
              Expanded(
                child: ListView(
                  children: [
                    CardTextField(
                      controller: numberEditingController,
                      label: 'card number',
                      hint: 'XXXX XXXX XXXX XXXX',
                      textInputType: TextInputType.number,
                      length: 16,
                      onTap: () {
                        setState(() {
                          flag = false;
                        });
                      },
                      onChange: (String v) {
                        setState(() {
                          cardNumber = v;
                        });
                      },
                    ),

                    GestureDetector(
                      onTap: () async {
                        flag = false;
                        await pickDate();
                        setState(() {
                          if(_pickedDate != null){
                            List<String> list = _pickedDate!.split('/');
                            expiryDate = list[0] + ' / '+  list[2][2]+list[2][3];
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsetsDirectional.only(start: 28, end: 10),
                          alignment: AlignmentDirectional.centerStart,
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF999999).withAlpha(25),
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey.shade300,width: 1.5)),
                          child: Row(
                            children: [
                              Text(_pickedDate ?? 'D/M/Y'),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: AppColors.Orange_COLOR,
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 15,),
                    CardTextField(
                      controller: cvvEditingController,
                      label: 'CVV',
                      textInputType: TextInputType.number,
                      length: 3,
                      hint: 'XXX',
                      onTap: () {
                        setState(() {
                          flag = true;
                        });
                      },
                      onChange: (String v) {
                        setState(() {
                          cvvCode = v;
                        });
                      },
                    ),
                    CardTextField(
                      controller: holderNameEditingController,
                      label: 'Holder Name',
                      hint: 'Holder Name',
                      onTap: () {
                        setState(() {
                          flag = false;
                        });
                      },
                      onChange: (String v) {
                        setState(() {
                          cardHolderName = v;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: AppColors.Orange_COLOR,
                            value: isVisa,
                            onChanged: (var selected) {
                              setState(() {
                                isVisa = true;
                              });
                            },
                            title: AppText(
                              text: 'VISA',
                              fontsize: 16,
                              color: AppColors.Orange_COLOR,
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.red,
                          width: 50,
                          thickness: 5,
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: AppColors.Orange_COLOR,
                            value: !isVisa,
                            onChanged: (var selected) {
                              setState(() {
                                isVisa = false;
                              });
                            },
                            title: AppText(
                              text: 'MASTER',
                              fontsize: 16,
                              color: AppColors.Orange_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await performSave(context);
                      },
                      child: AppText(
                        text: 'Save',
                        color: Colors.white,
                        fontsize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.Orange_COLOR,
                          minimumSize: Size(double.infinity, 64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future pickDate() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 61)),
      firstDate: DateTime.now().add(Duration(days: 61)),
      lastDate: DateTime.now().add(Duration(days : 365*5)),
    );
    if (dateTime != null) {
      _pickedDateValue = dateTime;
      var format = DateFormat.yMd();
      _pickedDate = format.format(dateTime);
      print('Date: ${_pickedDate}');
    }
  }


  // String? cardNumber;
  // String? expiryDate;
  // String? cardHolderName;
  // String? cvvCode;

  Future performSave(BuildContext context) async {
    if (checkData()) {
      await save(context);
    }
  }

  bool checkData() {
    if (_pickedDate != null &&
        numberEditingController.text.isNotEmpty &&
        holderNameEditingController.text.isNotEmpty &&
        cvvEditingController.text.isNotEmpty
        ) {
      return true;
    }
    Helper. showSnackBar(context, text: 'empty_field_error', error: true);
    return false;
  }

  Future save(BuildContext context) async {
    await CardGetxController.to.createCard(card: card,context: context);
  }

  MyCard get card {
    MyCard myCard = MyCard();
    myCard.cardNumber = numberEditingController.text;
    myCard.cvv = int.parse(cvvEditingController.text);
    myCard.holderName = holderNameEditingController.text;
    myCard.expDate = _pickedDate!;
    myCard.type = isVisa ? 'Visa' : 'Master';
    return myCard;
  }
}
