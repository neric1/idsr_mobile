import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:idsr/api/api.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';
import 'package:idsr/data/models/error_response.dart';
import 'package:idsr/data/models/success_response.dart';

class EntityRepositoryImpl extends EntityRepository {
  final Api api;
  EntityRepositoryImpl(this.api);


  @override
  Future<Either<ErrorResponse, SuccessResponse<Map<String,dynamic>>>> getTrackedEntity({required String programeId}) async {
    try {
      String path="trackedEntityInstances.json?pageSize=3000&program=$programeId&ou=RL2xfadEX0d;wI6iMMqyKRY;E5kAKg6J5AH;qsisNWxXBRJ;CHG4FtC04EF;cZw3GsPzk8o;Uf1jZm28TRD;iyafYFo3JMd;ZoH5flTZbXw;quwuhdH3jlw;ckFAHLjjv4e;bUtBmUt1pz6;OhZHTN8wn0t;jCQVCvr10mf;Vpy7G6Pg0bI;FPYfp66lui2;DssnVxramcD;XIDQyXiFXaM;oimhhFE0bb3;h6qi9TlulbD;dQU3sezzQ5L;CVkykjVpChR;NXkGPH5Twn1;ciyRYHh9dfs;jYYR4NWS3t0;ywifZLpWkxz;ZbAB3ZhhJcQ;T5oIRzBIFcp;jG1AZ4Uelw5;Z7dMsgJHc17;Lm31acFuYRp;Q3LPuIvVmqi;zyX24ahbfIm;auUPRM8dLFo;UnAAMtFzd8j;iyQFqn4HHQz;j6vs3cZbjQD;akKBwZfmuDv;kfvLKlmzpwN;HZtKIozL115;XhcIn2FWihU;ovvu8SlYevT;MUgtTwGrHce;DNMIVXBZt14;FBp81RH2tMk;yjrPjSm8VOc;YDWM8iCX4ZU&fields=*,enrollments[*,events[*,dataValues[dataElement,value]]]";

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