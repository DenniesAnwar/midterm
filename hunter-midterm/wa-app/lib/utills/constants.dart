import 'package:flutter/material.dart';

import 'colors.dart';

const rememberMeKey = 'rememberMe';
const tokenKey = 'tokenKey';
const emailKey = 'email';
const passwordKey = 'password';
const acceptPrivacyPolicy = 'accept_terms';
const passwordUpdateSuccessMessage = "Password updated successfully";

const marketPlace =
    "Have you written an original script with a unique story? Submit your script here. ";
const applyProgram =
    "Access the very best screenwriting resources. Apply to WoWriters Room here";
const nonUnion =
    "Are you a Non-Union Producer looking for your next screenplay? Find your next script here. ";
const union =
    "Are you a Union Producer looking for your next screenplay? Find your next script here. ";
const loremIpsumText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem";

const String stripekey =
    "pk_test_51Jf9rQCrdFKycvGvgeJKJTQdpotoir3wI38ilO4E6BwbkbavAcTYTKdQKgX210oPUmEsnYEZT9YYkQPBsMQCbth400OVzhz814";

const String kStory =
    'Jeremy Andrews and Casey McDougal met as Fine Arts students and bonded over a shared vision for ther future of Hollywood. Combining their respective experience in the tv and film industry, they\'ve set out to create a platform that connects up and coming screenwriters from across the globe with the people who can bring their life to work; producers.';
const String endeavorCommitment = ''
    'This 6 month intensive program requires candidates to be fully committed to the endeavor. While we are open to candidates who have a part-time or full-time job, it will be helpful for you to consider the program as a full time job. Are you able to make that type of commitment? ';

const String belongsTo = ''
    'Do you belong to a industry guild or Trade Association?';

const String availableForMeeting = ''
    'All Producers in our marketplace are vetted and require an interview. Are you available for a Zoom/Google Meet Interview?';

const String someAdmirer =
    'Who is someone in the industry you admire and why?\n (100 words or less)';
const String screenWritingRelation =
    'What are your long term plans as it relates to screenwriting? (i.e. finishing college, going to grad school)';
const String screenWritingBackground =
    'Do you consider yourself a dramatic writer, comedy writer, or something in between? If something in between, please explain';
const String scriptOptioned =
    'Please describe to us a time when your script was optioned. If you have never been optioned, tell us of a time when you tried to sell your script to producers and what happened (max 100 words)';
const String interestWoAccelerator =
    'What interests you most about our accelerator program? (100 words or less)';
const String writingDiscipline = 'What discipline best suits your skill set?';
const String youLikeUsToKnow = 'Anything else you would like us to know?';
const String learningProExpect =
    'What are you most hoping to learn from this program? (100 words or less)';
const String industryAwards =
    'Please list any producer, screenwriter, or other entertainment industry related awards or scholarships you have received.';
const String completedScripts =
    'How many scripts have you completed in the past?';
const String scriptOfInterest =
    'Please provide a brief summary of a script that you would be interested in working on in the program. (1000 words max) ';
const String uploadFiles =
    'Please attach a 10 page script sample of what you believe is a good example of your work. If your file is too LARGE, you can use the below to shrink. https://smallpdf.com/compress-pdf';
const String referencesSubTitle =
    'Please list two (2) references who are familiar with your work';
const String interview =
    'All Producers in our marketplace are vetted and require an interview. Are you available for a Zoom/Google Meet Interview?';
const String screenWriterChoosingDescription =
    'Gain access to our courses and mentorship programs to hone your skills, perfect your craft, and write marketable scripts that producers want to buy.';
const String producerChoosingDescription =
    'Join our invite-only marketplace, browse, option, and purchase production-ready scripts from trained writers across the globe.';

const String story =
    '* Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor * eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.* Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.Cras gravida bibendum dolor * eu varius. Morbi fermentum velit nisl, eget vehicula lorem sodales eget. Donec quis volutpat orci. Sed ipsum felis, tristique id egestas et, convallis ac velit. In consequat dolor libero, nec luctus orci rutrum nec. Phasellus vel arcu sed nibh ornare accumsan. Vestibulum in elementum erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean laoreet rhoncus ipsum eget tempus. Praesent convallis fermentum sagittis.';

class ScriptPurchaseType {
  static const String treatment = "treatment";
  static const String screenPlay = "screenplay";
  static const String durationExtension = "extension";
  static const String sixMonthSubscriptions = "6_months";
  static const String yearSubscription = "12_months";
}

class ScriptPurchaseDuration {
  static const String sixMonthSubscriptions = "6_months";
  static const String yearSubscription = "12_months";
}

class Subscriptions {
  static const String prodBasic = "prod_basic";
  static const String prodPremuim = "pro_premium";
  static const String scWriterSixMonth = "writer_six_months";
  static const String scWriterYearly = "writer_yearly";
}

class ScriptStatus {
  static const String inReview = "In Review";
  static const String rejected = "Rejected";
  static const String approved = "Approved";
}

class ApplicationStatus {
  static const String rejected = "rejected";
  static const String accpted = "accepted";
  static const String notSubmitted = "notSubmitted";
}

class InvalidTryKeys {
//---- try with invalid username and password

  String counter = 'invalidLoginTryCounter';
  String dateTime = 'lastInvalidTry';
}

OutlineInputBorder textFieldBorderDecoration = const OutlineInputBorder(
  borderSide: BorderSide(
    width: 0.5,
    color: kBorderColor,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

class OnBoardUrls {
  static const String refreshUrl =
      "https://material.io/resources/color/#!/?view.left=1&view.right=0&primary.color=01579B&secondary.color=558B2F";
  static const String retrunUrl = "https://www.google.com.pk/";
}

class CheckoutUrls {
  static const String refreshUrl =
      "https://material.io/resources/color/#!/?view.left=1&view.right=0&primary.color=01579B&secondary.color=558B2F";
  static const String retrunUrl = "https://www.google.com.pk/";
}
