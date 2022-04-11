/*! © 2022 imaoki | MIT License | https://github.com/imaoki */
(
  /* 初期化 */
  local mp = ::MxsPackStruct (getSourceFileName())
  /* 出力先ディレクトリ削除 */
  -- mp.DeleteDirectory @".\Distribution"

  /* コード切り出し */
  local StartupLoaderCode = mp.ClipFile @".\StartupLoader.ms" 1 -1

  /* コード置換 */
  local code = StartupLoaderCode

  /* インストールコード追加 */
  -- code = mp.AppendText code "::StartupLoaderStruct.Install()\n::StartupLoaderStruct\n"
  /* インストーラーオプション削除 */
  -- code = mp.RemoveInstallerOption code
  /* バンドルファイルを保存 */
  -- mp.WriteAllText @".\Distribution\StartupLoader.bundle.ms" code
  /* 最小化ファイルを保存 */
  code = mp.Minify code
  mp.WriteAllText @".\Distribution\StartupLoader.min.ms" code
  ok
)
