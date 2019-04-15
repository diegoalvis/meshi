/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

class DateUtils {
  static int getAgeFromDate(DateTime date) {
    int age = DateTime.now().year - date.year;
    if (DateTime.now().isBefore(DateTime(DateTime.now().year, date.month, date.day))) {
      age = age - 1;
    }
    return age;
  }
}
