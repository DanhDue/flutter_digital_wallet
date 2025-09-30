import java.io.FileInputStream
import java.util.Base64
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val dartEnvironmentVariables =
    mutableMapOf(
        "DART_DEFINES_APP_NAME" to "Wallet",
        "DART_DEFINES_APP_ID_SUFFIX" to null,
        "DART_DEFINES_BASE_URL" to "https://danhdue.com/",
    )

if (project.hasProperty("dart-defines")) {
    val dartDefinesStr = project.property("dart-defines").toString()
    dartDefinesStr.split(",").forEach { encoded ->
        val decoded = String(Base64.getDecoder().decode(encoded), Charsets.UTF_8)
        val pair = decoded.split("=")
        if (pair.size == 2) {
            dartEnvironmentVariables["DART_DEFINES_${pair[0]}"] = pair[1]
        }
    }
}

println("Dart defines: $dartEnvironmentVariables")

android {
    namespace = "com.danhdue.wallet"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.danhdue.wallet"
        applicationIdSuffix = dartEnvironmentVariables["DART_DEFINES_APP_ID_SUFFIX"]
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        versionNameSuffix = dartEnvironmentVariables["DART_DEFINES_APP_ID_SUFFIX"].toString()
        multiDexEnabled = true
        resValue("string", "app_name", dartEnvironmentVariables["DART_DEFINES_APP_NAME"].toString())
        ndk {
            // Filter for architectures supported by Flutter
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86_64")
        }
    }

    flavorDimensions += "default"

    signingConfigs {
        create("development") {
            storeFile = rootProject.file("./../secureFiles/signing/debug.keystore")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
        create("production") {
            val keystorePropertiesFile = rootProject.file("./../secureFiles/signing/keystore.properties")
            if (keystorePropertiesFile.exists()) {
                println("Keystore properties file found: ${keystorePropertiesFile.absolutePath}")
                val keystoreProperties = Properties()
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
                storeFile = rootProject.file("./../secureFiles/signing/${keystoreProperties["storeFile"]}")
                storePassword = keystoreProperties["storePassword"] as String
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
            } else {
                throw RuntimeException("Keystore properties file not found")
            }
        }
    }

    buildTypes {
        debug {
            isDebuggable = true
            enableUnitTestCoverage = false
            enableAndroidTestCoverage = false
            manifestPlaceholders["crashlyticsEnabled"] = false
            manifestPlaceholders["analyticsEnabled"] = false
        }
        release {
            isDebuggable = false
            isMinifyEnabled = true
            isShrinkResources = true
            enableUnitTestCoverage = false
            enableAndroidTestCoverage = false
            manifestPlaceholders["crashlyticsEnabled"] = true
            manifestPlaceholders["analyticsEnabled"] = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }

    productFlavors {
        create("dev") {
            signingConfig = signingConfigs.getByName("development")
        }
        create("stg") {
            signingConfig = signingConfigs.getByName("development")
        }
        create("prd") {
            signingConfig = signingConfigs.getByName("production")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.window:window:1.4.0")
    implementation("androidx.window:window-java:1.4.0")
    implementation("com.android.support:multidex:1.0.3")
}

flutter {
    source = "../.."
}
