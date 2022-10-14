import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/constants.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return  Container(
      color: const Color(0xff1C1D27),
      padding: const EdgeInsets.only(
          right: 30, left: 30, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeConfig.screenWidth < 820?_smBody(context):_lgBody(context),
          const SizedBox(height: 30,),
          Visibility(
            visible: SizeConfig.screenWidth > 820,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loadSmallText(title: '© Copyright 2021'),
                      Row(
                        children: [
                          loadSmallText(title: 'Privacy Policy'),
                          const SizedBox(
                            width: 20,
                          ),
                          loadSmallText(title: 'Terms & Conditions'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lgBody(BuildContext context){

    SizeConfig().init(MediaQuery.of(context).size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage('assets/images/wa_grey_logo.png'),
          height: 40,
          width: 80,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 10),
                    child:
                    loadMediumTitleText(title: 'Our Story'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: loadSmallText(title: kStory),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10),
                      child: loadMediumTitleText(title: 'Links'),
                    ),
                    loadMediumText(title: 'Our Courses'),
                    loadMediumText(title: 'Our Application'),
                    loadMediumText(
                        title: 'Partner With WoAccelerator'),
                    loadMediumText(title: 'FAQ'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10),
                      child: loadMediumTitleText(
                          title: 'Stay tuned for updates'),
                    ),
                    Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            minWidth: 140,
                            maxWidth: 430,
                          ),
                          width: 180,
                          child: TextFields.withoutController(
                              fillColor: const Color(0xff4D5B69),
                              borderRoundness: 4,
                              isFilled: true,
                              hint: 'Type your email',
                              mapKey: 'email', onSaved:(key,value){}),
                        ),
                        buildSubscribeButton(),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    loadMediumText(title: 'Follow us'),
                    Row(
                      children: [
                        socialIconContainer(imageName:'twitter-logo.png'),
                        const SizedBox(width: 30,),
                        socialIconContainer(imageName:'hand_wave.png'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _smBody(BuildContext context){

    SizeConfig().init(MediaQuery.of(context).size);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage('assets/images/wa_grey_logo.png'),
            height: 40,
            width: 80,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10),
                child:
                loadMediumTitleText(title: 'Our Story'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: loadSmallText(title: kStory),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10),
                  child: loadMediumTitleText(title: 'Links'),
                ),
                loadMediumText(title: 'Our Courses'),
                loadMediumText(title: 'Our Application'),
                loadMediumText(
                    title: 'Partner With WoAccelerator'),
                loadMediumText(title: 'FAQ'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10),
                  child: loadMediumTitleText(
                      title: 'Stay tuned for updates'),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFields.withoutController(
                          fillColor: const Color(0xff4D5B69),
                          borderRoundness: 4,
                          isFilled: true,
                          hint: 'Type your email',
                          mapKey: 'email', onSaved:(key,value){}),
                    ),
                    buildSubscribeButton(),
                  ],
                ),
                const SizedBox(height: 3,),
                loadMediumText(title: 'Follow us'),
                Row(
                  children: [
                    socialIconContainer(imageName:'twitter-logo.png'),
                    const SizedBox(width: 30,),
                    socialIconContainer(imageName:'hand_wave.png'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    loadSmallText(title: '© Copyright 2021'),
                    Row(
                      children: [
                        loadSmallText(title: 'Privacy Policy'),
                        const SizedBox(
                          width: 20,
                        ),
                        loadSmallText(title: 'Terms & Conditions'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loadSmallText({title}) => Text(
    title,
    textAlign: TextAlign.justify,
    style: TextStyle(
      color: Colors.grey,
      fontSize: SizeConfig.screenHeight < 665? 10:13,
      height: 1.4,
    ),
  );
  Widget loadMediumTitleText({title}) => Text(
    title,
    style: TextStyle(
      color: Colors.white,
      fontSize: SizeConfig.screenHeight < 665? 13:16,
      fontWeight: FontWeight.w500,
    ),
  );
  socialIconContainer({onTapped,required imageName})=>InkWell(
    onTap: onTapped,
    child: Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 8),
      height: 25,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image(image: AssetImage('assets/images/$imageName')),
    ),
  );
  buildSubscribeButton({onTapped})=>InkWell(
    onTap: onTapped,
    child:   Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      margin: const EdgeInsets.only(
        left: 6.0,
      ),
      child: const Text(
        'Subscribe',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
  Widget loadMediumText({title}) => Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.screenHeight < 665? 11:14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}


