import 'package:dartz/dartz.dart';
import 'package:idsr/data/models/error_response.dart';
import 'package:idsr/data/models/success_response.dart';
abstract class EntityRepository {
  EntityRepository();

  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> getTrackedEntity({required String programeId});
}