

## problem statement:

```dart

          > Could not GET 'https://dl.google.com/dl/android/maven2/androidx/activity/activity/1.0.0-alpha02/activity-1.0.0-alpha02.pom'.
               > dl.google.com
      > Could not resolve androidx.activity:activity:1.0.0-alpha02.
         > Could not get resource 'https://jcenter.bintray.com/androidx/activity/activity/1.0.0-alpha02/activity-1.0.0-alpha02.pom'.
            > Could not GET 'https://jcenter.bintray.com/androidx/activity/activity/1.0.0-alpha02/activity-1.0.0-alpha02.pom'.
               > jcenter.bintray.com

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 2m 17s
Running Gradle task 'assembleDebug'...
Running Gradle task 'assembleDebug'... Done                       143.8s (!)
The built failed likely due to AndroidX incompatibilities in a plugin. The tool is about to try using Jetfier to solve
the incompatibility.
✏️  Creating `android\settings_aar.gradle`...
[!] Flutter tried to create the file `android\settings_aar.gradle`, but failed.
To manually update `settings.gradle`, follow these steps:

    1. Copy `settings.gradle` as `settings_aar.gradle`
    2. Remove the following code from `settings_aar.gradle`:

        def localPropertiesFile = new File(rootProject.projectDir, "local.properties")
        def properties = new Properties()

        assert localPropertiesFile.exists()
        localPropertiesFile.withReader("UTF-8") { reader -> properties.load(reader) }

        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        apply from: "$flutterSdkPath/packages/flutter_tools/gradle/app_plugin_loader.gradle"

Exception: Please create the file and run this command again.
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter clean
Deleting build...                                               11,457ms (!)
Deleting .dart_tool...                                              15ms
Deleting Generated.xcconfig...                                       3ms
Deleting flutter_export_environment.sh...                            1ms
Deleting .flutter-plugins-dependencies...                            2ms
Deleting .flutter-plugins...                                         1ms
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter run
Running "flutter pub get" in KebabBankSeptemberOrderApp...          2.0s
Using hardware rendering with device sdk gphone x86 64 arm64. If you notice graphics artifacts, consider enabling software rendering with
"--enable-software-rendering".
Launching lib\main.dart on sdk gphone x86 64 arm64 in debug mode...
WARNING: [Processor] Library 'C:\Users\Taxi\.gradle\caches\modules-2\files-2.1\io.flutter\flutter_embedding_debug\1.0.0-435db234e4d35f772c90f31edeb3a347dfb6d7c1\b5e7cbcb97f6d5f4dcd4ca8ae5397eef3cdd71e8\flutter_embedding_debug-1.0.0-435db234e4d35f772c90f31edeb3a347dfb6d7c1.jar' contains references to both AndroidX and old support library. This seems like the library is partially migrated. Jetifier will try to rewrite the library anyway.
 Example of androidX reference: 'androidx/annotation/NonNull'
 Example of support library reference: 'android/support/annotation/NonNull'
Running Gradle task 'assembleDebug'...
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\blue_thermal_printer-1.1.1\android\src\main\java\id\kakzaki\blue_thermal_printer\BlueThermalPrinterPlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_core-0.5.0\android\src\main\java\io\flutter\plugins\firebase\core\FlutterFirebaseCorePlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\cloud_firestore-0.14.0+2\android\src\main\java\io\flutter\plugins\firebase\firestore\FlutterFirebaseFirestorePlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_auth-0.18.0+1\android\src\main\java\io\flutter\plugins\firebase\auth\FlutterFirebaseAuthPlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_storage-4.0.0\android\src\main\java\io\flutter\plugins\firebase\storage\FirebaseStoragePlugin.java:31: warning: [deprecation] PluginRegistry in io.flutter.plugin.common has been deprecated
import io.flutter.plugin.common.PluginRegistry;
                               ^
ing: [deprecation] PluginRegistry in io.flutter.plugin.common has been deprecated
  public static void registerWith(PluginRegistry.Registrar registrar) {
                                  ^
2 warnings
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\flutter_bluetooth_basic-0.1.5\android\src\main\java\com\tablemi\flutter_bluetooth_basic\FlutterBluetoothBasicPlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\path_provider-1.6.14\android\src\main\java\io\flutter\plugins\pathprovider\PathProviderPlugin.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\shared_preferences-0.5.10\android\src\main\java\io\flutter\plugins\sharedpreferences\SharedPreferencesPlugin.java:11import io.flutter.plugin.common.PluginRegistry;
                               ^
C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\shared_preferences-0.5.10\android\src\main\java\io\flutter\plugins\sharedpreferences\SharedPreferencesPlugin.java:18: warning: [deprecation] PluginRegistry in io.flutter.plugin.common has been deprecated
  public static void registerWith(PluginRegistry.Registrar registrar) {
                                  ^
2 warnings
C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\sqflite-1.3.1+1\android\src\main\java\com\tekartik\sqflite\SqflitePlugin.java:34: warning: [deprecation] PluginRegistry in io.flutter.plugin.common has been deprecated
import io.flutter.plugin.common.PluginRegistry.Registrar;
                               ^
C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\sqflite-1.3.1+1\android\src\main\java\com\tekartik\sqflite\SqflitePlugin.java:34: warning: [deprecation] PluginRegistry in io.flutter.plugin.common has been deprecated
import io.flutter.plugin.common.PluginRegistry.Registrar;
                               ^
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Running Gradle task 'assembleDebug'...                          (This is taking an unexpectedly long time.)       ⣟Terminate batch job (Y/N)?
^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.22.0-10.0.pre.355, on Microsoft Windows [Version 10.0.19041.450], locale en-US)

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Android Studio (version 4.0)
[✓] VS Code, 64-bit edition (version 1.49.0)
[✓] Connected device (1 available)

• No issues found!
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp>
                                                      flutter ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> ^C
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter version 1.22.0-2.0.pre.140
[!] The "version" command is deprecated and will be removed in a future version of Flutter. See https://flutter.dev/docs/development/tools/sdk/releases for previous
releases of Flutter.

╔══════════════════════════════════════════════════════════════════════════════╗
║ Warning: "flutter version" will leave the SDK in a detached HEAD state.      ║
║ If you are using the command to return to a previously installed SDK version ║
║ consider using the "flutter downgrade" command instead.                      ║
╚══════════════════════════════════════════════════════════════════════════════╝


Are you sure you want to proceed? [y|n]: y
There is no version: 1.22.0-2.0.pre.140
Unable to checkout version branch for version 1.22.0-2.0.pre.140: ProcessException: Process exited abnormally:
error: pathspec '1.22.0-2.0.pre.140' did not match any file(s) known to git
  Command: git checkout 1.22.0-2.0.pre.140
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter version
[!] The "version" command is deprecated and will be removed in a future version of Flutter. See https://flutter.dev/docs/development/tools/sdk/releases for previous
releases of Flutter.

1.23.0-4.0.pre
1.22.0-12.1.pre
1.20.4
1.22.0-12.0.pre
1.20.3
1.22.0-9.0.pre
1.21.0-9.2.pre


1.22.0-1.0.pre


1.21.0-9.1.pre
1.20.2
1.21.0-9.0.pre
1.20.1
1.20.0
1.21.0-7.0.pre
1.20.0-7.4.pre
1.20.0-7.3.pre
1.21.0-5.0.pre
1.20.0-7.2.pre
1.21.0-1.0.pre
1.20.0-7.1.pre
1.20.0-7.0.pre
1.20.0-3.0.pre
1.19.0-4.3.pre
1.17.5
1.20.0-2.0.pre
1.19.0-4.2.pre
1.20.0-1.0.pre
1.17.4
1.19.0-4.1.pre
1.20.0-0.0.pre
1.19.0-5.0.pre
1.19.0-4.0.pre
1.17.3
1.19.0-3.0.pre
1.19.0-2.0.pre
1.17.2
1.18.0-11.1.pre
1.17.1
1.19.0-1.0.pre
1.19.0-0.0.pre
1.18.0-13.0.pre
1.18.0-12.0.pre
1.18.0-11.0.pre
1.18.0-9.0.pre
1.18.0-10.0.pre
1.17.0
1.17.0-3.4.pre
1.17.0-3.3.pre
1.18.0-8.0.pre
1.18.0-7.0.pre
1.17.0-3.2.pre
1.18.0-6.0.pre
1.18.0-dev.5.0
1.18.0-dev.4.0
1.18.0-dev.3.0
1.17.0-dev.3.1
1.18.0-dev.2.0
1.18.0-dev.1.0
1.18.0-dev.0.0
1.17.0-dev.5.0
1.17.0-dev.4.0
1.17.0-dev.3.0
1.17.0-dev.2.0
1.17.0-dev.1.0
1.17.0-dev.0.0
v1.12.13+hotfix.9
v1.16.3
v1.16.2
v1.16.1
v1.16.0
v1.15.22
v1.15.21
v1.15.20
v1.15.19
flutter-0.0-candidate.1
v1.15.18
v1.15.17
v1.15.16
v1.15.15
v1.15.14
v1.15.13
v1.15.12
v1.15.11
v1.15.10
v1.15.9
v1.15.8
v1.15.7
v1.15.6
v1.15.5
v1.15.4
v1.12.13+hotfix.8
v1.15.3
v1.15.2
v1.15.1
v1.15.0
v1.14.6
v1.12.13+hotfix.7
v1.14.5
v1.14.4
v1.14.3
v1.14.2
v1.14.1
v1.14.0
v1.13.9
v1.13.8
v1.13.7
v1.13.6
v1.13.5
v1.13.4
v1.13.3
v1.13.2
v1.12.13+hotfix.6
v1.12.13+hotfix.5
v1.13.1
v1.12.13+hotfix.4
v1.12.13+hotfix.3
v1.12.13+hotfix.2
v1.13.0
v1.12.13+hotfix.1
v1.12.16
v1.12.15
v1.12.14
v1.12.13
v1.12.12
v1.12.11
v1.12.10
v1.12.9
v1.12.8
v1.12.7
v1.12.6
v1.12.5
v1.12.4
v1.12.3
v1.12.2
v1.12.1
v1.12.0
v1.11.0
v1.10.16
v1.10.15
v1.9.1+hotfix.6
v1.9.1+hotfix.5
v1.10.14
v1.10.13
v1.10.12
v1.10.11
v1.10.10
v1.10.9
v1.10.8
v1.10.7
v1.9.1+hotfix.4
v1.9.1+hotfix.3
v1.10.6
v1.10.5
v1.10.4
v1.10.3
v1.10.2
v1.9.1+hotfix.2
v1.10.1
v1.10.0
v1.9.1+hotfix.1
v1.9.7
v1.9.6
v1.9.5
v1.9.4
v1.9.3
v1.9.2
v1.9.1
v1.9.0
v1.8.4
v1.8.3
v1.7.8+hotfix.4
v1.8.2
v1.7.8+hotfix.3
v1.8.1
v1.7.8+hotfix.2
v1.7.8+hotfix.1
v1.8.0
v1.7.11
v1.7.10
v1.7.9
v1.7.8
v1.7.7
v1.7.6
v1.7.5
v1.7.4
v1.7.3
v1.7.2
v1.7.1
v1.7.0
v1.6.7
v1.6.6
v1.6.5
v1.6.4
v1.6.3
v1.6.2
v1.6.1
v1.6.0
v1.5.4-hotfix.2
v1.5.4-hotfix.1
v1.5.8
v1.5.7
v1.5.6
v1.5.5
v1.5.4
v1.5.3
v1.5.2
v1.5.1
v1.5.0
v1.4.19
v1.4.9-hotfix.1
v1.4.18
v1.4.17
v1.4.16
v1.4.15
v1.4.14
v1.4.13
v1.4.12
v1.4.11
v1.4.10
v1.4.9
v1.4.8
v1.4.6-hotfix.1
v1.4.5-hotfix.2
v1.4.7
v1.4.6
v1.4.5
v1.4.4
v1.4.3
v1.4.2
v1.4.1
v1.4.0
v1.3.14
v1.3.13
v1.3.12
v1.3.11
v1.3.10
v1.3.9
v1.3.8
v1.3.7
v1.3.6
v1.3.5
v1.3.4
v1.3.3
v1.3.2
v1.3.1
v1.3.0
v1.2.2
v1.2.1
v1.2.0
v1.1.9
v1.1.8
v1.1.7
v1.1.6
v1.1.5
v1.1.4
v1.1.3
v1.1.2
v1.1.1
v1.1.0
v1.0.0
v0.11.13
v0.11.12
v0.11.11
v0.11.10
v0.11.9
v0.11.8
v0.11.7
v0.11.6
v0.11.5
v0.11.4
v0.11.3
v0.11.2
v0.11.1
v0.11.0
v0.10.2
v0.10.1
v0.10.0
v0.9.6
v0.9.5
v0.9.4
v0.9.3
v0.9.2
v0.9.1
v0.9.0
v0.8.7
v0.8.6
v0.8.5
v0.8.4
v0.8.3
v0.8.2
v0.8.1
v0.8.0
v0.7.5
v0.7.4
v0.7.3
v0.7.2
v0.7.1
v0.7.0
v0.6.2
v0.6.1
v0.6.0
v0.5.8
v0.5.7
v0.5.6
v0.5.5
v0.5.4
v0.5.3
v0.5.2
v0.5.1
v0.5.0
v0.4.4
v0.4.3
v0.4.2
v0.4.1
v0.4.0
v0.3.6
v0.3.5
v0.3.4
v0.3.3
v0.3.2
v0.3.1
v0.3.0
v0.2.11
v0.2.10
v0.2.9
v0.2.8
v0.2.7
v0.2.6
v0.2.5
v0.2.4
v0.2.3
v0.2.2
v0.2.1
v0.2.0
v0.1.9
v0.1.8
v0.1.7
v0.1.6
v0.1.5
v0.1.4
v0.1.3
v0.1.2
v0.1.1
v0.1.0
v0.0.24
v0.0.23
v0.0.22
0.0.21
v0.0.21
0.0.20
v0.0.20
0.0.19
v0.0.19
0.0.18
v0.0.18
0.0.17
v0.0.17
0.0.16
v0.0.16
0.0.15
v0.0.15
0.0.14
v0.0.14
0.0.13
v0.0.13
0.0.12
v0.0.12
0.0.11
v0.0.11
0.0.10
v0.0.10
0.0.9
v0.0.9
0.0.8
v0.0.8
0.0.7
v0.0.7
0.0.6
v0.0.6
v0.0.20-alpha
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp>
```


## previous version::

```dart


## flutter doctor issue:  ## flutter doctor -v: output: windows lptp...1st september 2020...

```dart


Microsoft Windows [Version 10.0.19041.388]
(c) 2020 Microsoft Corporation. All rights reserved.

C:\Users\Taxi>flutter doctor -v
[√] Flutter (Channel master, 1.22.0-2.0.pre.140, on Microsoft Windows [Version 10.0.19041.388], locale en-US)

```
## current version:

```dart

PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp> flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.22.0-10.0.pre.355, on Microsoft Windows [Version 10.0.19041.450], locale en-US)

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Android Studio (version 4.0)
[✓] VS Code, 64-bit edition (version 1.49.0)
[✓] Connected device (1 available)

• No issues found!
PS C:\Users\Taxi\Programs\KebabBankSeptemberOrderApp>
```

## flutter version 1.22.0-1.0.pre

## september 25, 2020::::

## in mint pc there is no problem:

```dart
taxi@taxi-HP-ProBook-4540s:~/Programs/orderApp$ flutter doctor
^F^F^CDoctor summary (to see all details, run flutter doctor -v):
^C^C[✓] Flutter (Channel master, 1.22.0-10.0.pre.356, on Linux, locale en_US.UTF-8)
⣽taxi@taxi-HP-ProBook-4540s:~/Programs/orderApp$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.22.0-10.0.pre.356, on Linux, locale en_US.UTF-8)

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Android Studio (version 4.0)
[✓] VS Code (version 1.48.2)
[✓] Connected device (1 available)

• No issues found!
taxi@taxi-HP-ProBook-4540s:~/Programs/orderApp$

```