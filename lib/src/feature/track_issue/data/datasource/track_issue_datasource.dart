import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../model/track_issue_model.dart';

class TrackIssueDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, List<TrackIssueModel>>> getAllTrackIssues(NoParams params) async {
    try {
      List<Map<String, dynamic>> response = await _client.from('order_issues').select().order('reported_at', ascending: false);
      List<TrackIssueModel> trackIssues = [];
      for (var item in response) {
        trackIssues.add(TrackIssueModel.fromJson(item));
      }
      return Right(trackIssues);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure(errorMessage: e.message));
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: e.toString()));
    }
  }
}
