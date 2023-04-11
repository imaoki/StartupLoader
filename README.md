# StartupLoader

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)

Manage startup scripts.
<!-- スタートアップスクリプトを管理する。 -->

## Development Environment
<!-- 開発環境 -->

`3ds Max 2024`

## Install
<!-- インストールする -->

Execute `install.ms`.
<!-- `install.ms`を実行する。 -->

## Uninstall
<!-- アンインストールする -->

Execute `uninstall.ms`.
<!-- `uninstall.ms`を実行する。 -->

## Standalone version
<!-- スタンドアローン版 -->

### Install
<!-- インストールする -->

Execute `Distribution\StartupLoader.min.ms`.
<!-- `Distribution\StartupLoader.min.ms`を実行する。 -->

### Uninstall
<!-- アンインストールする -->

```maxscript
::startupLoader.Uninstall()
```

## Usage
<!-- 使い方 -->

### Register script file
<!-- スクリプトファイルを登録する -->

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName())
)
```

#### Evaluate as installer
<!-- インストーラとして評価する -->

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName()) installer:true
)
```

#### Conditions for evaluation as installer
<!-- インストーラとして評価するための条件 -->

* The result of the evaluation of the script file must be a structure definition.
  <!-- スクリプトファイルの評価結果が構造体定義であること。 -->

* Must have a static method `Install` with no arguments.
  <!-- 引数を持たない静的メソッド`Install`を持っていること。 -->

### Unregister script file
<!-- スクリプトファイルを登録解除する -->

```maxscript
if isProperty ::startupLoader "UnregisterFile" do (
  ::startupLoader.UnregisterFile (getSourceFileName())
)
```

* The argument of the `UnregisterFile` method is the same file path as at the time of registration.
  <!-- `UnregisterFile`メソッドの引数には登録時と同じファイルパスを渡す。 -->

### Save Startup Script
<!-- スタートアップスクリプトの保存 -->

```maxscript
::startupLoader.Write()
```

## Default startup file location
<!-- 既定のスタートアップファイルの保存先 -->

`C:\Users\<UserName>\AppData\Local\Autodesk\3dsMax\<Version>\ENU\scripts\startup\StartupLoader.ms`

## License
<!-- ライセンス -->

[MIT License](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)
