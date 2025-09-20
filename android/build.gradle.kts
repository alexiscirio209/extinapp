plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.extintores" // 👈 PON AQUÍ TU NAMESPACE
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.extintores" // 👈 DEBE COINCIDIR CON EL NAMESPACE
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            // Activamos minify para que shrinkResources funcione
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            // Para debug normalmente no necesitamos minify ni shrink
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    // Opcional: para evitar errores con Java 8+ features
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7")
}
