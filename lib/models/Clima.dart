class Clima {
  int _temperatura;
  String _cidade;
  String _descricao;
  int _umidade;
  String _nascerSol;
  String _porSol;

  Clima();

  int get temperatura => _temperatura;

  set temperatura(int value) {
    _temperatura = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get porSol => _porSol;

  set porSol(String value) {
    _porSol = value;
  }

  String get nascerSol => _nascerSol;

  set nascerSol(String value) {
    _nascerSol = value;
  }

  int get umidade => _umidade;

  set umidade(int value) {
    _umidade = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }
}