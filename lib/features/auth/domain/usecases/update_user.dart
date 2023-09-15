import 'package:equatable/equatable.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';

class UpdateUserUseCase extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUserUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.fullName,
          userData: '',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => throw UnimplementedError();
}
