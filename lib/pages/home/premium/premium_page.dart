/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/bloc/profile_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/register/basic/basic_register_page.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class PremiumPage extends StatelessWidget with HomeSection {


  @override
  Widget build(BuildContext context) {
    // TODO construir aqui la vista
    return Center(child: Text("Vista de premium"));
  }
}
