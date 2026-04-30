# Prevent R8/ProGuard from removing GetStorage and Flutter path utilities
-keep class io.flutter.util.PathUtils { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class com.rethink.get_storage.** { *; }

# Keep GetX and other reflection-based libraries safe
-keep class io.get.** { *; }
-dontwarn io.get.**