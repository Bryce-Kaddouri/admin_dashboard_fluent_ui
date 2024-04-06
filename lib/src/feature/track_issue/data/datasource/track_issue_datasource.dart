import 'package:admin_dashboard/src/feature/track_issue/business/param/track_issue_update_status.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../model/track_issue_model.dart';

class TrackIssueDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, List<TrackIssueModel>>> getAllTrackIssues(
      NoParams params) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('order_issues')
          .select()
          .order('reported_at', ascending: false);
      print(response);
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

  Future<Either<DatabaseFailure, bool>> updateTrackIssue(
      TrackIssueUpdateStatusParam param) async {
    try {
      Map<String, dynamic> map = {
        'resolution_status': TrackIssueModel.getStatusString(param.status),
        'resolved_at': DateTime.now().toIso8601String(),
      };

      await _client
          .from('order_issues')
          .update(map)
          .eq('order_id', param.orderId)
          .eq('order_date', param.orderDate.toIso8601String());
      return Right(true);
    } on PostgrestException catch (e) {
      return Left(DatabaseFailure(errorMessage: e.message));
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: e.toString()));
    }
  }
}
