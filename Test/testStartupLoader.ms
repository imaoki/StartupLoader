/*! © 2022 imaoki | MIT License | https://github.com/imaoki */
(
  -- clearListener()

  local nowTime = (DotNetClass "System.DateTime").Now.ToString "HH:mm:ss"
  local sw = DotNetObject "System.Diagnostics.Stopwatch"

  local environmentClass = DotNetClass "System.Environment"
  local pathClass = DotNetClass "System.IO.Path"

  local currentFile = getSourceFileName()
  local currentDir = pathClass.GetDirectoryName currentFile

  local getFullPath
  fn getFullPath path = (
    environmentClass.CurrentDirectory = currentDir
    pathClass.GetFullPath path
  )

  local actual
  local expected
  local testDef
  local testObj

  format "[run %]@\"%\"\n" nowTime currentFile
  /* Setup Start ------------------------------------------------------------ */
  local fileClass = DotNetClass "System.IO.File"

  local testFilePath1 = currentDir + @"\test1.ms"
  local testFilePath2 = currentDir + @"\test2.ms"

  local startupFilePath = SymbolicPaths.GetPathValue "$UserStartupScripts" + @"\StartupLoader.ms"

  -- 既存のスタートアップスクリプトファイルを削除
  if fileClass.Exists startupFilePath do (
    fileClass.Delete startupFilePath
  )

  testDef = fileIn (getFullPath @"..\StartupLoader.ms")
  /* Setup End -------------------------------------------------------------- */
  sw.Start()
  /* Test Start ------------------------------------------------------------- */
  /* インスタンス作成 */
  testObj = testDef()
  -- グローバル変数の存在を確認
  actual = ::TestValueStruct (GlobalVars.IsGlobal "startupLoader")
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- グローバル変数の値を確認
  actual = ::TestValueStruct (GlobalVars.Get "startupLoader")
  expected = ::TestValueStruct testObj
  assert (actual.Equals expected == true)
  -- スタートアップファイルの存在を確認
  actual = ::TestValueStruct (fileClass.Exists startupFilePath)
  expected = ::TestValueStruct false
  assert (actual.Equals expected == true)

  /* GetInstallerFlags */
  actual = ::TestValueStruct (testObj.GetInstallerFlags())
  expected = ::TestValueStruct #()
  assert (actual.Equals expected == true)

  /* GetScriptFiles */
  actual = ::TestValueStruct (testObj.GetScriptFiles())
  expected = ::TestValueStruct #()
  assert (actual.Equals expected == true)

  /* GetStartupFilePath */
  actual = ::TestValueStruct (testObj.GetStartupFilePath())
  expected = ::TestValueStruct startupFilePath
  assert (actual.Equals expected == true)

  /* Install */
  actual = ::TestValueStruct (testDef.Install())
  expected = ::TestValueStruct ok
  assert (actual.Equals expected == true)
  -- グローバル変数の存在を確認
  actual = ::TestValueStruct (GlobalVars.IsGlobal "startupLoader")
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- グローバル変数の値を確認
  actual = ::TestValueStruct (GlobalVars.Get "startupLoader")
  expected = ::TestValueStruct testObj
  assert (actual.Equals expected == true)
  -- スタートアップファイルの存在を確認
  actual = ::TestValueStruct (fileClass.Exists startupFilePath)
  expected = ::TestValueStruct false
  assert (actual.Equals expected == true)

  /* OnPreSystemShutdown */

  /* RegisterFile */
  -- 通常のスクリプト
  actual = ::TestValueStruct (testObj.RegisterFile testFilePath1)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- インストーラー
  actual = ::TestValueStruct (testObj.RegisterFile testFilePath2 installer:true)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- 重複登録（状態変化無し）
  actual = ::TestValueStruct (testObj.RegisterFile testFilePath1)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)

  -- testObj.Dump()

  /* Write */
  actual = ::TestValueStruct (testObj.Write())
  expected = ::TestValueStruct ok
  assert (actual.Equals expected == true)
  -- スタートアップファイルの存在を確認
  actual = ::TestValueStruct (fileClass.Exists startupFilePath)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)

  /* UnregisterFile */
  actual = ::TestValueStruct (testObj.UnregisterFile testFilePath1)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)

  /* Uninstall */
  actual = ::TestValueStruct (testObj.Uninstall())
  expected = ::TestValueStruct ok
  assert (actual.Equals expected == true)
  -- グローバル変数の存在を確認
  actual = ::TestValueStruct (GlobalVars.IsGlobal "startupLoader")
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- グローバル変数の値を確認
  actual = ::TestValueStruct (GlobalVars.Get "startupLoader")
  expected = ::TestValueStruct undefined
  assert (actual.Equals expected == true)
  -- スタートアップファイルの存在を確認
  actual = ::TestValueStruct (fileClass.Exists startupFilePath)
  expected = ::TestValueStruct false
  assert (actual.Equals expected == true)
  /* Test End --------------------------------------------------------------- */
  sw.Stop()
  /* Teardown Start --------------------------------------------------------- */
  /* Teardown End ----------------------------------------------------------- */
  format "[end %]%ms\n" nowTime (sw.ElapsedMilliseconds as Integer)
  ok
)
