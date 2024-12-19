# くじアプリローカルテスト用スクリプト
# /get_loto_results?pw=doraemon810&date=2024-02-02

from flask import Flask, request, jsonify
import sqlite3
from datetime import datetime

app = Flask(__name__)
# app.json.ensure_ascii = False
app.config['JSON_AS_ASCII'] = False


valid_password = 'doraemon810'

@app.before_request
def check_authentication():
    pw = request.args.get('pw')
    if pw != valid_password:
        return jsonify({'error': 'c'}), 401

# テスト用loto6の結果のみ
@app.route('/test')
def test_get_loto_results():
    date = request.args.get('date')

    if date is None:
        return jsonify({'error': 'd'}), 400

    # 日付が正しい形式か確認
    if not is_valid_date(date):
        return jsonify({'error': 'vd'}), 400

    # 認証が成功した場合のみデータベースに接続
    conn = sqlite3.connect('lotodata.db')
    c = conn.cursor()

    lotos = ["loto6"]
    result_dict = {}
    for loto in lotos:
        c.execute(f"SELECT * FROM {loto} WHERE date > ?", (date,))
        rows = c.fetchall()
        header = [description[0] for description in c.description]
        result = [{header[i]: value for i, value in enumerate(row)} for row in rows]
        result_dict[loto] = result

    conn.close()
    return jsonify(result_dict)

@app.route('/get_loto_results')
def get_loto_results():
    date = request.args.get('date')

    if date is None:
        return jsonify({'error': 'd'}), 400

    # 日付が正しい形式か確認
    if not is_valid_date(date):
        return jsonify({'error': 'vd'}), 400

    # 認証が成功した場合のみデータベースに接続
    conn = sqlite3.connect('lotodata.db')
    c = conn.cursor()

    lotos = ["qoo", "n3", "n4", "bingo", "miniloto", "loto6", "loto7"]
    result_dict = {}
    for loto in lotos:
        c.execute(f"SELECT * FROM {loto} WHERE date > ?", (date,))
        rows = c.fetchall()
        header = [description[0] for description in c.description]
        result = [{header[i]: value for i, value in enumerate(row)} for row in rows]
        result_dict[loto] = result

    conn.close()
    return jsonify(result_dict)

def is_valid_date(date):
    try:
        # 日付文字列をdatetimeオブジェクトに変換し、エラーが発生しなければ有効な日付と見なす
        datetime.strptime(date, '%Y-%m-%d')
        return True
    except ValueError:
        # エラーが発生した場合は無効な日付と見なす
        return False

if __name__ == '__main__':
    app.run()
