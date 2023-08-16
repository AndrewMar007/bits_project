import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/domain/repositories/user_repository.dart';
import 'package:bits_project/features/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  FetchUser? usecase;
  MockUserRepository? mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = FetchUser(mockUserRepository!);
  });

  const email = 'andy@gmail.com';
  const password = '123';
  final userData = UserModel(
      id: '3213123adsad23',
      email: "avicii@gmail.com",
      password: '/5sxhr7sFJUsY/pluEDgOIr4QAXJc//rpXqMDD1P2gmJ75hAHRbu',
      login: 'Avicii');

  test('should get data for the user from the repository', () async {
    when(() => mockUserRepository!.getUser(any(), any())).thenAnswer((_) {
      return Future<UserModel>.value(userData);
    });
    // print(mockUserRepository!.getUser('andy', '12'));
    final result = await usecase!(email: email, password: password);

    expect(result, userData);

    verify(() => mockUserRepository!.getUser(email, password));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
