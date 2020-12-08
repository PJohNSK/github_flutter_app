import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/models/repos.dart';
import 'package:github/helper/locator.dart';
import 'package:github/services/api.dart';
import 'package:github/services/secure_storage.dart';
import 'base_view_model.dart';

class DashboardViewModel extends BaseViewModel {


  final API _api = locator<API>();
  ReposList _repoList;
  SecureStorage secureStorage = SecureStorage();

  String name, avatarUrl;
  List<Repos> get repos => _repoList.repos;

  getRepos() async {
    setState(ViewState.Busy);
    name = await secureStorage.getName();
    avatarUrl = await secureStorage.getAvatarUrl();
    print(avatarUrl);
    var repo = await _api.getRepo();
    _repoList = repo;
    setState(ViewState.Idle);
    notifyListeners();
  }
}