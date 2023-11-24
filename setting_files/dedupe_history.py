import IPython

# デフォルトのIPython履歴マネージャーを使用
HISTORY = IPython.get_ipython().history_manager

def dedupe_history(info):
    query = ("DELETE FROM history WHERE rowid NOT IN "
             "(SELECT MAX(rowid) FROM history GROUP BY source)")
    db = HISTORY.db
    db.execute(query)
    db.commit()

def set_pre_run_cell_event():
    IPython.get_ipython().events.register("pre_run_cell", dedupe_history)

# 新しいセッションの開始時に履歴の重複を削除
dedupe_history(None)  # 新しいセッションの開始時には引数を渡さない
# コマンドを実行するたびに履歴の重複を削除
set_pre_run_cell_event()