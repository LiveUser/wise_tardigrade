# Keep the mobile_scanner plugin classes and internal references
-keep class com.mobile_scanner.** { *; }
-keep class com.google.mlkit.** { *; }
-keep class androidx.camera.** { *; }
-dontwarn com.mobile_scanner.**
-dontwarn com.google.mlkit.**
-dontwarn androidx.camera.**