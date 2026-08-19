


import 'package:blog_app/core/app_errors/server_exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource{

  Session? get currentSession;

  Future<UserModel> signUpWithEmailAndPassword({required String name,required String email,required String password});
  Future<UserModel> loginWithEmailAndPassword({required String email,required String password});

  Future<UserModel?> getUserProfileData();

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);


  @override
  // TODO: implement currentSession
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailAndPassword({required String email, required String password})async {
    try{
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password
      );
      debugPrint("response from supabaseClient : $response");
      if(response.user == null){
        throw ServerException(message: "Something went wrong");
      }
      return UserModel.fromJson(response.user!.toJson());
    }on AuthApiException catch(e){
      debugPrint("error : $e");
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({required String name, required String email, required String password})async {
    final data = {"name": name};
    try{
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: data
      );
      debugPrint("response from supabaseClient : $response");
      if(response.user == null){
        throw ServerException(message: "Something went wrong");
      }else{
        return UserModel.fromJson(response.user!.toJson());
      }
    }on AuthApiException catch(e){
      debugPrint("error : $e");
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel?> getUserProfileData() async {

    try{
      if(currentSession != null){

      }
    }catch(e){
      debugPrint("error : $e");
      throw ServerException(message: e.toString());
    }
    return null;
  }



}




