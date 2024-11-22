import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:genesia_demo/core/base/base_provider.dart';
import 'package:genesia_demo/extensions/extensions.dart';
import 'package:genesia_demo/generated/assets.gen.dart';
import 'package:genesia_demo/model/ai_friend_data.dart';
import 'package:genesia_demo/model/user_profile.dart';
import 'package:genesia_demo/modules/dashboard/dashboard.dart';
import 'package:genesia_demo/services/preferenceService/pref_manager.dart';
import 'package:genesia_demo/utils/utils.dart';
import 'package:provider/provider.dart';

part 'onboard_provider.dart';
part 'onboard_screen.dart';
part 'widget/enter_your_name_onboard_screen.dart';
part 'widget/your_dob_screen.dart';
part 'widget/your_pronouns_screen.dart';
part 'widget/your_interests_screen.dart';
part 'widget/choose_ai_friend_screen.dart';
part 'widget/choose_name_and_gender_screen.dart';
part 'widget/choose_friend_age_screen.dart';
part 'widget/choose_friend_personality_screen.dart';
