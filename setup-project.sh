#!/bin/bash
set -e

PROJECT="quran-app"
PKG="tech.meshari.quran"
PKG_PATH="tech/meshari/quran"

mkdir -p $PROJECT/app/src/main/java/$PKG_PATH
mkdir -p $PROJECT/app/src/main/res/layout
mkdir -p $PROJECT/app/src/main/res/values
mkdir -p $PROJECT/app/src/main/res/values-night
mkdir -p $PROJECT/app/src/main/res/drawable
mkdir -p $PROJECT/app/src/main/res/mipmap-hdpi
mkdir -p $PROJECT/app/src/main/res/mipmap-mdpi
mkdir -p $PROJECT/app/src/main/res/mipmap-xhdpi
mkdir -p $PROJECT/app/src/main/res/mipmap-xxhdpi
mkdir -p $PROJECT/app/src/main/res/mipmap-xxxhdpi
mkdir -p $PROJECT/app/src/main/res/xml
mkdir -p $PROJECT/gradle/wrapper

# Download icon
curl -sL "https://quran.meshari.tech/icon-192.png" -o $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-mdpi/ic_launcher.png

# settings.gradle.kts
cat > $PROJECT/settings.gradle.kts << 'SETTINGS'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolution {
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "QuranApp"
include(":app")
SETTINGS

# Fix: use dependencyResolutionManagement
sed -i 's/dependencyResolution/dependencyResolutionManagement/' $PROJECT/settings.gradle.kts

# build.gradle.kts (project)
cat > $PROJECT/build.gradle.kts << 'PBUILD'
plugins {
    id("com.android.application") version "8.2.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.21" apply false
}
PBUILD

# app/build.gradle.kts
cat > $PROJECT/app/build.gradle.kts << 'ABUILD'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "tech.meshari.quran"
    compileSdk = 34

    defaultConfig {
        applicationId = "tech.meshari.quran"
        minSdk = 24
        targetSdk = 34
        versionCode = 2
        versionName = "1.1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    
    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.webkit:webkit:1.9.0")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
}
ABUILD

# AndroidManifest.xml
cat > $PROJECT/app/src/main/AndroidManifest.xml << 'MANIFEST'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.QuranApp"
        android:usesCleartextTraffic="true"
        android:hardwareAccelerated="true">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:configChanges="orientation|screenSize|keyboardHidden"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="https" android:host="quran.meshari.tech" />
            </intent-filter>
        </activity>
    </application>
</manifest>
MANIFEST

# SplashActivity - not needed, using theme splash

# MainActivity.kt
cat > $PROJECT/app/src/main/java/$PKG_PATH/MainActivity.kt << 'KOTLIN'
package tech.meshari.quran

import android.annotation.SuppressLint
import android.content.pm.ActivityInfo
import android.graphics.Bitmap
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import android.webkit.*
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private lateinit var progressBar: ProgressBar
    private lateinit var swipeRefresh: SwipeRefreshLayout
    private val QURAN_URL = "https://quran.meshari.tech"

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Fullscreen immersive
        window.statusBarColor = Color.parseColor("#0a1628")
        window.navigationBarColor = Color.parseColor("#0a1628")
        
        setContentView(R.layout.activity_main)
        
        progressBar = findViewById(R.id.progressBar)
        swipeRefresh = findViewById(R.id.swipeRefresh)
        webView = findViewById(R.id.webView)

        setupWebView()
        
        swipeRefresh.setOnRefreshListener {
            webView.reload()
        }
        swipeRefresh.setColorSchemeColors(Color.parseColor("#c8a84e"))

        val url = intent?.data?.toString() ?: QURAN_URL
        webView.loadUrl(url)
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun setupWebView() {
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            databaseEnabled = true
            cacheMode = WebSettings.LOAD_DEFAULT
            allowFileAccess = true
            allowContentAccess = true
            setSupportZoom(true)
            builtInZoomControls = true
            displayZoomControls = false
            loadWithOverviewMode = true
            useWideViewPort = true
            mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
            mediaPlaybackRequiresUserGesture = false
            setGeolocationEnabled(true)
            userAgentString = userAgentString + " QuranApp/1.1"
        }
        
        webView.setBackgroundColor(Color.parseColor("#0a1628"))

        webView.webViewClient = object : WebViewClient() {
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                progressBar.visibility = View.VISIBLE
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                progressBar.visibility = View.GONE
                swipeRefresh.isRefreshing = false
            }

            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                val url = request?.url?.toString() ?: return false
                if (url.contains("quran.meshari.tech") || url.contains("meshari.tech")) {
                    return false
                }
                return false
            }
        }

        webView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                progressBar.progress = newProgress
                if (newProgress == 100) progressBar.visibility = View.GONE
            }
            
            override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback?) {
                callback?.invoke(origin, true, false)
            }
        }
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    override fun onResume() {
        super.onResume()
        webView.onResume()
    }

    override fun onPause() {
        webView.onPause()
        super.onPause()
    }
}
KOTLIN

# activity_main.xml layout
cat > $PROJECT/app/src/main/res/layout/activity_main.xml << 'LAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<androidx.swiperefreshlayout.widget.SwipeRefreshLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/swipeRefresh"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#0a1628">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <WebView
            android:id="@+id/webView"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />

        <ProgressBar
            android:id="@+id/progressBar"
            style="@android:style/Widget.ProgressBar.Horizontal"
            android:layout_width="match_parent"
            android:layout_height="3dp"
            android:layout_alignParentTop="true"
            android:progressTint="#c8a84e"
            android:progressBackgroundTint="#0a1628"
            android:max="100"
            android:visibility="gone" />
    </RelativeLayout>
</androidx.swiperefreshlayout.widget.SwipeRefreshLayout>
LAYOUT

# strings.xml
cat > $PROJECT/app/src/main/res/values/strings.xml << 'STRINGS'
<resources>
    <string name="app_name">القرآن الكريم</string>
</resources>
STRINGS

# themes.xml
cat > $PROJECT/app/src/main/res/values/themes.xml << 'THEMES'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.QuranApp" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="colorPrimary">#1a5c2e</item>
        <item name="colorPrimaryVariant">#0a1628</item>
        <item name="colorOnPrimary">#c8a84e</item>
        <item name="android:statusBarColor">#0a1628</item>
        <item name="android:navigationBarColor">#0a1628</item>
        <item name="android:windowBackground">#0a1628</item>
        <item name="android:windowSplashScreenBackground">#0a1628</item>
    </style>
</resources>
THEMES

# network_security_config.xml
cat > $PROJECT/app/src/main/res/xml/network_security_config.xml << 'NETSEC'
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="false">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>
</network-security-config>
NETSEC

# gradle-wrapper.properties
cat > $PROJECT/gradle/wrapper/gradle-wrapper.properties << 'GWRAP'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.2-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
GWRAP

# gradlew
cat > $PROJECT/gradlew << 'GRADLEW'
#!/bin/sh
exec gradle "$@"
GRADLEW

# Use gradle wrapper - download it
cd $PROJECT
gradle wrapper --gradle-version 8.2 || {
  # If gradle not available, create a minimal wrapper
  echo "Downloading gradle wrapper..."
  mkdir -p gradle/wrapper
  curl -sL "https://raw.githubusercontent.com/niclasvanesch/gradle-wrapper/master/gradlew" -o gradlew || true
  curl -sL "https://raw.githubusercontent.com/niclasvanesch/gradle-wrapper/master/gradle/wrapper/gradle-wrapper.jar" -o gradle/wrapper/gradle-wrapper.jar || true
  chmod +x gradlew
}
cd ..

# proguard-rules.pro
touch $PROJECT/app/proguard-rules.pro

# gradle.properties
cat > $PROJECT/gradle.properties << 'GPROP'
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
android.nonTransitiveRClass=true
GPROP

echo "Project setup complete!"
ls -la $PROJECT/
ls -la $PROJECT/app/src/main/java/$PKG_PATH/
