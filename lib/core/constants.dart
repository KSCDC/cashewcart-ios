import 'package:flutter/material.dart';

const Widget kWidth = SizedBox(width: 10);
const Widget kHeight = SizedBox(height: 10);
const Widget kProfileScreenGap = SizedBox(height: 20);
const Duration connectionTimeoutDuration = Duration(seconds: 60);

const String ACCESSTOKEN = "accessToken";
const String REFRESHTOKEN = "refreshToken";
const String EMAIL = "email";
const String PHONE = "phoneNo";
const String ENCRYPTEDPASSWORD = "password";
const String ENCKEY = "encryptionKey";
const String ENCIV = "encryptionIv";

enum LoginWith {
  google,
  apple,
  facebook,
}

const List<String> statesList = [
  "N1 2LL",
  "state2",
  "state3",
  "state4",
];

const String aboutKsdcEnglish =
    "The Kerala State Cashew Development Corporation Limited (KSCDC) was incorporated in July 1969 and started Commercial activities in the year 1971 as a company fully owned by the Government of Kerala. From the modest beginning in 1969 Corporation has now grown into a large organization playing a pivotal role in Cashew industry.\n\nKSCDC, an ISO 22000-2005 company, is running 30 cashew factories across Kerala State with an annual production capacity of 30,000 Metric Tonnes. More than 15000 workers and 500 staff members are working in these factories. KSCDC now have a turnover of Rs. 250 crore.\n\nKSCDC acts as a model employer in the field of cashew industry mainly to protect the interest of its workers and to provide maximum employment to them ensuring their statutory benefits like minimum wages, bonus and etc. prevailing in the cashew industry.\n\nWith an objective to promote Cashew based Value Added Products KSCDC have over these years developed a variety of Value added Products from Cashew Apple and Cashew Kernels. These products are being widely appreciated in the domestic market and in the international market (see the Value Added products).\n\nKSDC also aims at backward integration of its product line and has promoted Cashew Plantations in association with the Kerala State Agency for Cashew Cultivation and have cultivated Cashew Plantation across 25 hectares in its facilities.";

const String aboutKsdcMalayalam =
    "കാഷ്യൂ  കോർപ്പറേഷനെക്കുറിച്ച്:- 1969 ൽ രൂപീകൃതമായ കേരള സംസ്ഥാന കശുവണ്ടി വികസന കോർപ്പറേഷൻ 1971 ൽ കേരള സർക്കാരിൻ്റെ പൂർണ്ണ ഉടമസ്ഥതയിലുള്ള ഒരു കമ്പനിയായി വ്യാവസായിക അടിസ്ഥാനത്തിലുള്ള പ്രവർത്തനങ്ങൾ ആരംഭിച്ചു. 1969- തിൽ ആരംഭിച്ച ഈ സ്ഥാപനം ഇപ്പോൾ കശുവണ്ടി വ്യവസായത്തിൽ സുപ്രധാനമായ പങ്ക് വഹിക്കുന്ന വലിയ വ്യവസായ സ്ഥാപനമായി വളർന്നു കഴിഞ്ഞു.\n\n22000-2005 ISO  സർട്ടിഫൈഡ് കമ്പനിയായ കാഷ്യൂ കോർപ്പറേഷന് കേരളത്തിലാകെ 30,000 മെട്രിക് ടൺ വാർഷിക ഉൽപ്പാദന ശേഷിയുള്ള 30 കശുവണ്ടി ഫാക്ടറികളുണ്ട്. 15000- ത്തിലധികം തൊഴിലാളികളും 500 റിലധികം ജീവനക്കാരും കോർപ്പറേഷൻ്റെ വിവിധ ഫാക്ടറികളിൽ ജോലി ചെയ്തുവരുന്നു. ഇപ്പോൾ  കെ.എസ്‌.സി.ഡി.സി ക്ക് ഏകദേശം 250 കോടി രൂപയുടെ വാർഷിക വിറ്റുവരവുണ്ട്.\n\nകശുവണ്ടി വ്യവസായത്തിലെ മാതൃകാ സ്ഥാപനമായി പ്രവർത്തിച്ചുവരുന്ന സംസ്ഥാന കശുവണ്ടി വികസന കോർപ്പറേഷൻ തൊഴിലാളികളുടെ താൽപ്പര്യം സംരക്ഷിക്കുകയും, അവർക്ക് പരമാവധി തൊഴിലും, നിലവിലുള്ള മിനിമം കൂലി, ബോണസ് തുടങ്ങിയ നിയമാനുസൃത ആനുകൂല്യങ്ങളും നൽകിവരുന്നു. കശുവണ്ടി പരിപ്പിൽ നിന്നുമുള്ള മൂല്യവർദ്ധിത ഉൽപ്പന്നങ്ങൾ പ്രോത്സാഹിപ്പിക്കുന്നതിൻ്റെ ഭാഗമായി കാഷ്യൂ ആപ്പിളിൽ നിന്നും, കശുവണ്ടി പരിപ്പിൽ നിന്നും വൈവിധ്യമാർന്ന മൂല്യവർദ്ധിത ഉൽപ്പന്നങ്ങൾ വികസിപ്പിച്ച് വിപണിയിൽ എത്തിച്ചിട്ടുണ്ട്.  ഈ ഉൽപ്പന്നങ്ങൾക്ക് ആഭ്യന്തര, അന്താരാഷ്‌ട്ര വിപണികളിൽ നല്ല മൂല്യം ലഭിക്കുന്നുണ്ട്. (മൂല്യവർദ്ധിത  ഉൽപ്പന്നങ്ങളുടെ പേജ്  നോക്കിയാലും) കാഷ്യൂ കോർപ്പറേഷൻ കേരള സംസ്ഥാന കശുമാവ്  കൃഷി വികസന ഏജൻസിയുമായി സഹകരിച്ചുകൊണ്ട് കശുമാവ് കൃഷി പ്രോത്സാഹിപ്പിക്കുകയും, ഇപ്രകാരം ഏകദേശം 25 ഹെക്ടറിൽ കശുമാവ് കൃഷി ചെയ്തു വരികയും ചെയ്യുന്നു";
