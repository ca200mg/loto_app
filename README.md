# loto_app

みずほ銀行の数字選択式宝くじの管理のためのアプリのローカルテストバージョン

## Getting Started

VScodeでFlutterの開発環境を整えてから実行してください。

#### 仮想環境を準備して、flaskをインストールする

`$ pip install flask`

#### for_test.pyの「くじアプリローカルテスト用スクリプト」を動かす

ブラウザで下記のURLを指定する

`http://127.0.0.1:5000/get_loto_results?pw=doraemon810&date=2024-12-01`

jsonが表示されたら成功

#### アプリを動かす

lib > main.dart
エミュレータでアプリを動かす
