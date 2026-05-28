import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:idsr/api/api.dart';
import 'package:idsr/api/apiv2.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/data/models/error_response.dart';
import 'package:idsr/data/models/success_response.dart';
class ThresholdRepositoryImpl extends ThresholdRepository {

  final ApiV2 api;
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
  @override
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchDiseaseTrends({required String orgunit, required String period,required String disease}) async {
    try {
      String path =
          "analytics?dimension=dx:$disease&dimension=pe:$period&dimension=ou:$orgunit;&dimension=EqaDkGuN7Ot:hfhhnK5nxbH";
      // print("objectmychchhc");
      //
      // if (orgunit.split(";").length == 1) {
      //   path =
      //   "analytics?dimension=dx:DE_GROUP-OKhIhT1Zc01&dimension=pe:$period&dimension=ou:$orgunit;LEVEL-L0Us87yIjEA&dimension=co:MNOAEOAkXbd&showHierarchy=true";
      // }
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
  @override
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchEbola({required String orgunit, required String period}) async {
    try {
      String path =
          "analytics?dimension=pe:$period&dimension=dx:kdSei0GD1mM;OoZOXclQI7l;A8p2Spxdtg1;E9dLxqaEL3g;"
          "TkU5wnfxDej;CCBkZTKOOBi;frhtqy7Y0Uj;dnKH6OmmNQ7;q3cWAxVfVYb;"
         // "x28x7SuFG41;p3d1hYMt634;wCLYwuwF3to;dnKH6OmmNQ7;nu7ehyfR6Jd;B8hUrK2uPIw;walTSZ0tu26;tR7O6OL5qwu;lZBQ6wwD82V;CMoy66F82LG;fFmn8Kub8so;Ju2c5YSZjGT;oY558eiTAI0;Z3oearf1sNY;SUOpwhEvhry;p8aIQHxhYpJ;VqZJorqoYGG;dX2IrlMkkDC;frhtqy7Y0Uj;WPY5FlpyolK;Yllh1ry8OPT;cxtNcukj27w;LZoTuZGiUIw;nnhN0lkczuU;CCBkZTKOOBi;Xy6I9T4L6lf;hOWNm4ZmeVD;CS5bbmdYFYK;Nc1oZMXNDsX;Yld4mGS41Bf;SSO5DMn4AHS;jhXnOAFoEZF;MoxfHiMQ4h2;Su4jgoBX7Pi;hK1quiDL2Jd;zVOk8vBZGGy;Lf1QJanPqSR;q3cWAxVfVYb;TqYDGRMR09l"
          "&dimension=ou:$orgunit&aggregationType=NONE&skipData=false&showHierarchy=true";
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