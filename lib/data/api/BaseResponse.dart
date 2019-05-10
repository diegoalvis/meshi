/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

class BaseResponse<T>{
  bool success;
  T data;
  int error;
  BaseResponse({this.success, this.data, this.error});
}