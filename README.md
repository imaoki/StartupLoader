# StartupScriptLoader

スタートアップスクリプトを管理する

# インストール

1.  スクリプトを実行

2.  インスタンス化とスタートアップスクリプトの保存

    * グローバル変数名に既定値の`startupScriptLoader`を使用する場合

      ```maxscript
      (StartupScriptLoaderStruct()).Save()
      ```

    * グローバル変数名を指定する場合

      ```maxscript
      (StartupScriptLoaderStruct "hoge").Save()
      ```

    グローバル変数の定義は内部的に行われる。

## アンインストール

```maxscript
;::startupScriptLoader.Uninstall()
```

## 使い方

1.  ツールの起動処理が完了する箇所（Openイベント等）に以下のコードを挿入する。

    ```maxscript
    if isProperty ::startupScriptLoader "RegisterScript" do (
      ::startupScriptLoader.RegisterScript (getSourceFileName())
      ::startupScriptLoader.Save()
    )
    ```
2.  ツールの終了処理が完了する箇所（Closeイベント等）に以下のコードを挿入する。

    ```maxscript
    if isProperty ::startupScriptLoader "UnregisterScript" do (
      ::startupScriptLoader.UnregisterScript (getSourceFileName())
      ::startupScriptLoader.Save()
    )
    ```
