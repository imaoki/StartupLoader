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

  local TestObserverStruct
  struct TestObserverStruct (
    public Callback,
    public Context,

    public fn StructName = #TestObserverStruct,

    public fn Equals obj = (
      local isEqualStructName = isStruct obj \
          and isProperty obj #StructName \
          and classOf obj.StructName == MAXScriptFunction \
          and obj.StructName() == this.StructName()

      local isEqualProperties = isProperty obj #Callback \
          and isProperty obj #Context \
          and obj.Callback == this.Callback \
          and obj.Context == this.Context

      isEqualStructName and isEqualProperties
    ),

    on Create do ()
  )

  local expectedScriptFiles = #()
  local expectedStartupFilePath = SymbolicPaths.GetPathValue "$UserStartupScripts" + @"\StartupLoader.ms"

  local updateObject
  fn updateObject context params type: = (
    -- format "updateObject params:% type:%\n" params type
    if classOf params == Array do (
      for param in params do (
        case param of (
          (#ScriptFiles): (
            actual = ::TestValueStruct (testObj.GetScriptFiles())
            expected = ::TestValueStruct expectedScriptFiles
            assert (actual.Equals expected == true)
          )
          default: ()
        )
      )
    )
    ok
  )

  local testFilePath = currentDir + @"\test.ms"

  testDef = fileIn (getFullPath @"..\StartupLoader.ms")
  /* Setup End -------------------------------------------------------------- */
  sw.Start()
  /* Test Start ------------------------------------------------------------- */
  /* インスタンス作成 */
  testObj = testDef()
  testObj.AddObserver (TestObserverStruct updateObject testObj)
  -- グローバル変数の存在を確認
  actual = ::TestValueStruct (GlobalVars.IsGlobal "startupLoader")
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- グローバル変数の値を確認
  actual = ::TestValueStruct (GlobalVars.Get "startupLoader")
  expected = ::TestValueStruct testObj
  assert (actual.Equals expected == true)
  -- スタートアップファイルの存在を確認
  actual = ::TestValueStruct (fileClass.Exists expectedStartupFilePath)
  expected = ::TestValueStruct false
  assert (actual.Equals expected == true)

  /* GetScriptFiles */
  expectedScriptFiles = #()
  actual = ::TestValueStruct (testObj.GetScriptFiles())
  expected = ::TestValueStruct expectedScriptFiles
  assert (actual.Equals expected == true)

  /* GetStartupFilePath */
  actual = ::TestValueStruct (testObj.GetStartupFilePath())
  expected = ::TestValueStruct expectedStartupFilePath
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
  actual = ::TestValueStruct (fileClass.Exists expectedStartupFilePath)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)

  /* OnPreSystemShutdown */

  /* RegisterScript */
  expectedScriptFiles = #(testFilePath)
  actual = ::TestValueStruct (testObj.RegisterScript testFilePath)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- 登録されたファイルを確認
  actual = ::TestValueStruct (testObj.GetScriptFiles())
  expected = ::TestValueStruct expectedScriptFiles
  assert (actual.Equals expected == true)

  -- testObj.Dump()

  /* Save */

  /* UnregisterScript */
  expectedScriptFiles = #()
  actual = ::TestValueStruct (testObj.UnregisterScript testFilePath)
  expected = ::TestValueStruct true
  assert (actual.Equals expected == true)
  -- 登録されたファイルを確認
  actual = ::TestValueStruct (testObj.GetScriptFiles())
  expected = ::TestValueStruct expectedScriptFiles
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
  actual = ::TestValueStruct (fileClass.Exists expectedStartupFilePath)
  expected = ::TestValueStruct false
  assert (actual.Equals expected == true)
  /* Test End --------------------------------------------------------------- */
  sw.Stop()
  /* Teardown Start --------------------------------------------------------- */
  /* Teardown End ----------------------------------------------------------- */
  format "[end %]%ms\n" nowTime (sw.ElapsedMilliseconds as Integer)
  ok
)
