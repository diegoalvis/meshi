/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

class BaseResponse {
  bool success;
  dynamic data;
  int error;

  BaseResponse({this.success, this.data, this.error});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}
