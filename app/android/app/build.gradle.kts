plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sentia.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.sentia.app"
        // Versiones mínimas: [PENDIENTE] en docs/12 (sugerido minSdk 24).
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // resValue (nombre de la app por flavor) está desactivado por defecto en AGP 9.
    buildFeatures {
        resValues = true
    }

    // Flavors (docs/02 Etapa 0). Cada uno se instala aparte en el mismo
    // dispositivo. Ejecutar con: flutter run --flavor dev -t lib/main_dev.dart
    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "SentIA Dev")
        }
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "SentIA Staging")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "SentIA")
        }
    }

    buildTypes {
        release {
            // TODO(etapa-2): firma de release propia (keystore fuera del repo)
            // antes de la beta cerrada. Por ahora usa las llaves de debug.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
