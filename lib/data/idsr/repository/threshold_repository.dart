import 'package:dartz/dartz.dart';
import 'package:idsr/data/models/error_response.dart';
import 'package:idsr/data/models/success_response.dart';
abstract class ThresholdRepository {
  ThresholdRepository();

  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchThreshold({required String orgunit, required String period});
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchDiseaseTrends({required String orgunit, required String period,required String disease});
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> fetchEbola({required String orgunit, required String period});
}