import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:idsr/api/api.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/data/models/error_response.dart';
import 'package:idsr/data/models/success_response.dart';
class ThresholdRepositoryImpl extends ThresholdRepository {

  final Api api;
  ThresholdRepositoryImpl(this.api);



  @override
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchThreshold({required String orgunit, required String period}) async {
    try {
      String path =
          "analytics?dimension=dx:DE_GROUP-OKhIhT1Zc01&dimension=pe:$period&dimension=ou:$orgunit;&dimension=co:MNOAEOAkXbd";

      if (orgunit.split(";").length == 1) {
        path =
        "analytics?dimension=dx:DE_GROUP-OKhIhT1Zc01&dimension=pe:$period&dimension=ou:$orgunit;LEVEL-L0Us87yIjEA&dimension=co:MNOAEOAkXbd&showHierarchy=true";
      }
      final response = await api.dio.get(path);
      return Right(SuccessResponse<Map<String,dynamic>>(response.statusCode,response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorResponse(e.response?.statusCode??0,e.response?.data!=null?e.response?.data["detail"]:"Unknown error occurred"));
      }
      // debugPrint(e.toString());
      return Left(ErrorResponse(0,'Unknown error occurred'));
    }
  }
}