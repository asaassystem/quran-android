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
mkdir -p $PROJECT/app/src/main/res/anim
mkdir -p $PROJECT/gradle/wrapper

# Download logo from server
curl -sL "https://quran.meshari.tech/logoo.png" -o $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-mdpi/ic_launcher.png

# Also copy as round icon
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xhdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-hdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-mdpi/ic_launcher_round.png

# Copy logo to drawable for splash screen
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/drawable/splash_logo.png

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

# build.gradle.kts (project)
cat > $PROJECT/build.gradle.kts << 'BUILD'
plugins {
    id("com.android.application") version "8.2.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.20" apply false
}
BUILD

# gradle.properties
cat > $PROJECT/gradle.properties << 'PROPS'
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.nonTransitiveRClass=true
kotlin.code.style=official
PROPS

# gradle-wrapper.properties
cat > $PROJECT/gradle/wrapper/gradle-wrapper.properties << 'WRAPPER'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.5-bin.zip
networkTimeout=10000
validateDistributionUrl=true
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
WRAPPER

# app/build.gradle.kts
cat > $PROJECT/app/build.gradle.kts << 'APPBUILD'
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
        versionCode = 3
        versionName = "2.0.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
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

    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
    implementation("androidx.webkit:webkit:1.9.0")
    implementation("androidx.core:core-splashscreen:1.0.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
}
APPBUILD

# proguard-rules.pro
cat > $PROJECT/app/proguard-rules.pro << 'PROGUARD'
-keepattributes JavascriptInterface
-keepclassmembers class tech.meshari.quran.WebAppInterface {
    public *;
}
PROGUARD

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
        android:roundIcon="@mipmap/ic_launcher_round"
        android:label="القرآن الكريم"
        android:supportsRtl="true"
        android:theme="@style/Theme.QuranApp"
        android:usesCleartextTraffic="false"
        android:networkSecurityConfig="@xml/network_security_config">

        <activity
            android:name=".SplashActivity"
            android:exported="true"
            android:theme="@style/Theme.QuranApp.Splash"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="https" android:host="quran.meshari.tech" />
            </intent-filter>
        </activity>

        <activity
            android:name=".MainActivity"
            android:exported="false"
            android:screenOrientation="portrait"
            android:configChanges="orientation|screenSize|keyboard|keyboardHidden"
            android:hardwareAccelerated="true" />

    </application>
</manifest>
MANIFEST

# network_security_config.xml
cat > $PROJECT/app/src/main/res/xml/network_security_config.xml << 'NETSEC'
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="false">
        <domain includeSubdomains="true">quran.meshari.tech</domain>
        <domain includeSubdomains="true">meshari.tech</domain>
    </domain-config>
</network-security-config>
NETSEC

# SplashActivity.kt - Native splash screen with logoo.png
cat > $PROJECT/app/src/main/java/$PKG_PATH/SplashActivity.kt << 'SPLASH'
package tech.meshari.quran

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.animation.AlphaAnimation
import android.view.animation.AnimationSet
import android.view.animation.ScaleAnimation
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val logo = findViewById<ImageView>(R.id.splashLogo)
        val title = findViewById<TextView>(R.id.splashTitle)
        val subtitle = findViewById<TextView>(R.id.splashSubtitle)

        // Animate logo
        val scaleAnim = ScaleAnimation(0.5f, 1f, 0.5f, 1f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f)
        scaleAnim.duration = 800

        val fadeIn = AlphaAnimation(0f, 1f)
        fadeIn.duration = 800

        val animSet = AnimationSet(true)
        animSet.addAnimation(scaleAnim)
        animSet.addAnimation(fadeIn)
        logo.startAnimation(animSet)

        // Animate text with delay
        val textFade = AlphaAnimation(0f, 1f)
        textFade.duration = 600
        textFade.startOffset = 400
        title.startAnimation(textFade)

        val subFade = AlphaAnimation(0f, 1f)
        subFade.duration = 600
        subFade.startOffset = 600
        subtitle.startAnimation(subFade)

        Handler(Looper.getMainLooper()).postDelayed({
            startActivity(Intent(this, MainActivity::class.java))
            overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
            finish()
        }, 2000)
    }
}
SPLASH

# MainActivity.kt - Native app with toolbar and WebView
cat > $PROJECT/app/src/main/java/$PKG_PATH/MainActivity.kt << 'MAIN'
package tech.meshari.quran

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Bundle
import android.view.View
import android.webkit.*
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.material.appbar.MaterialToolbar
import com.google.android.material.bottomnavigation.BottomNavigationView

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private lateinit var progressBar: ProgressBar
    private lateinit var swipeRefresh: SwipeRefreshLayout
    private lateinit var toolbar: MaterialToolbar
    private lateinit var bottomNav: BottomNavigationView
    private lateinit var offlineView: View
    private lateinit var toolbarTitle: TextView
    private lateinit var toolbarLogo: ImageView

    private val BASE_URL = "https://quran.meshari.tech"
    private val LOCATION_REQUEST_CODE = 100

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        toolbar = findViewById(R.id.toolbar)
        toolbarTitle = findViewById(R.id.toolbarTitle)
        toolbarLogo = findViewById(R.id.toolbarLogo)
        setSupportActionBar(toolbar)
        supportActionBar?.setDisplayShowTitleEnabled(false)

        webView = findViewById(R.id.webView)
        progressBar = findViewById(R.id.progressBar)
        swipeRefresh = findViewById(R.id.swipeRefresh)
        bottomNav = findViewById(R.id.bottomNav)
        offlineView = findViewById(R.id.offlineView)

        setupWebView()
        setupSwipeRefresh()
        setupBottomNav()
        setupOfflineRetry()

        if (isNetworkAvailable()) {
            loadUrl(BASE_URL)
        } else {
            showOfflineView()
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun setupWebView() {
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            databaseEnabled = true
            cacheMode = WebSettings.LOAD_DEFAULT
            setSupportZoom(false)
            builtInZoomControls = false
            displayZoomControls = false
            loadWithOverviewMode = true
            useWideViewPort = true
            allowFileAccess = false
            allowContentAccess = false
            mixedContentMode = WebSettings.MIXED_CONTENT_NEVER_ALLOW
            userAgentString = webView.settings.userAgentString + " QuranApp/2.0"
            mediaPlaybackRequiresUserGesture = false
        }

        webView.webViewClient = object : WebViewClient() {
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                progressBar.visibility = View.VISIBLE
                offlineView.visibility = View.GONE
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                progressBar.visibility = View.GONE
                swipeRefresh.isRefreshing = false
                // Hide install banner inside webview (we have native app)
                view?.evaluateJavascript(
                    "document.getElementById('install-banner')?.remove();", null
                )
                // Inject native app detection
                view?.evaluateJavascript(
                    "window.isNativeApp = true; document.body.classList.add('native-app');", null
                )
            }

            override fun onReceivedError(view: WebView?, request: WebResourceRequest?, error: WebResourceError?) {
                if (request?.isForMainFrame == true) {
                    showOfflineView()
                }
            }

            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                val url = request?.url?.toString() ?: return false
                return if (url.contains("quran.meshari.tech") || url.contains("meshari.tech")) {
                    false
                } else {
                    val intent = android.content.Intent(android.content.Intent.ACTION_VIEW, request.url)
                    startActivity(intent)
                    true
                }
            }
        }

        webView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                progressBar.progress = newProgress
                if (newProgress == 100) {
                    progressBar.visibility = View.GONE
                }
            }

            override fun onGeolocationPermissionsShowPrompt(
                origin: String?,
                callback: GeolocationPermissions.Callback?
            ) {
                if (ContextCompat.checkSelfPermission(this@MainActivity,
                        Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                    callback?.invoke(origin, true, false)
                } else {
                    ActivityCompat.requestPermissions(this@MainActivity,
                        arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), LOCATION_REQUEST_CODE)
                }
            }
        }

        webView.addJavascriptInterface(WebAppInterface(this), "AndroidApp")
    }

    private fun setupSwipeRefresh() {
        swipeRefresh.setColorSchemeColors(
            ContextCompat.getColor(this, R.color.gold),
            ContextCompat.getColor(this, R.color.green)
        )
        swipeRefresh.setOnRefreshListener {
            webView.reload()
        }
    }

    private fun setupBottomNav() {
        bottomNav.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.nav_quran -> {
                    loadUrl(BASE_URL)
                    toolbarTitle.text = "القرآن الكريم"
                    true
                }
                R.id.nav_prayer -> {
                    webView.evaluateJavascript(
                        "document.querySelector('[data-tab=\"prayer\"]')?.click();", null
                    )
                    toolbarTitle.text = "أوقات الصلاة"
                    true
                }
                R.id.nav_qibla -> {
                    webView.evaluateJavascript(
                        "document.querySelector('[data-tab=\"qibla\"]')?.click();", null
                    )
                    toolbarTitle.text = "القبلة"
                    true
                }
                R.id.nav_bookmarks -> {
                    webView.evaluateJavascript(
                        "document.querySelector('[data-tab=\"bookmarks\"]')?.click();", null
                    )
                    toolbarTitle.text = "المحفوظات"
                    true
                }
                else -> false
            }
        }
    }

    private fun setupOfflineRetry() {
        offlineView.setOnClickListener {
            if (isNetworkAvailable()) {
                offlineView.visibility = View.GONE
                webView.visibility = View.VISIBLE
                loadUrl(BASE_URL)
            } else {
                Toast.makeText(this, "لا يوجد اتصال بالإنترنت", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun loadUrl(url: String) {
        webView.visibility = View.VISIBLE
        offlineView.visibility = View.GONE
        webView.loadUrl(url)
    }

    private fun showOfflineView() {
        offlineView.visibility = View.VISIBLE
        webView.visibility = View.GONE
        progressBar.visibility = View.GONE
        swipeRefresh.isRefreshing = false
    }

    private fun isNetworkAvailable(): Boolean {
        val cm = getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = cm.activeNetwork ?: return false
        val capabilities = cm.getNetworkCapabilities(network) ?: return false
        return capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == LOCATION_REQUEST_CODE && grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            webView.reload()
        }
    }
}
MAIN

# WebAppInterface.kt - JavaScript interface for native features
cat > $PROJECT/app/src/main/java/$PKG_PATH/WebAppInterface.kt << 'WEBINTERFACE'
package tech.meshari.quran

import android.content.Context
import android.webkit.JavascriptInterface
import android.widget.Toast

class WebAppInterface(private val context: Context) {
    @JavascriptInterface
    fun showToast(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }

    @JavascriptInterface
    fun getAppVersion(): String {
        return "2.0.0"
    }

    @JavascriptInterface
    fun isNativeApp(): Boolean {
        return true
    }
}
WEBINTERFACE

# activity_splash.xml - Splash screen layout with logo
cat > $PROJECT/app/src/main/res/layout/activity_splash.xml << 'SPLASHLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/splash_bg">

    <ImageView
        android:id="@+id/splashLogo"
        android:layout_width="200dp"
        android:layout_height="200dp"
        android:src="@drawable/splash_logo"
        android:scaleType="fitCenter"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintBottom_toTopOf="@id/splashTitle"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintVertical_chainStyle="packed"
        android:contentDescription="شعار القرآن الكريم" />

    <TextView
        android:id="@+id/splashTitle"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="القرآن الكريم"
        android:textSize="28sp"
        android:textColor="@color/gold"
        android:textStyle="bold"
        android:fontFamily="serif"
        android:layout_marginTop="24dp"
        app:layout_constraintTop_toBottomOf="@id/splashLogo"
        app:layout_constraintBottom_toTopOf="@id/splashSubtitle"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <TextView
        android:id="@+id/splashSubtitle"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="للاستماع والتلاوة"
        android:textSize="16sp"
        android:textColor="@color/text_secondary"
        android:layout_marginTop="8dp"
        app:layout_constraintTop_toBottomOf="@id/splashTitle"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <ProgressBar
        android:layout_width="32dp"
        android:layout_height="32dp"
        android:layout_marginBottom="48dp"
        android:indeterminateTint="@color/gold"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
SPLASHLAYOUT

# activity_main.xml - Main layout with toolbar, webview, bottom nav
cat > $PROJECT/app/src/main/res/layout/activity_main.xml << 'MAINLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/background">

    <com.google.android.material.appbar.MaterialToolbar
        android:id="@+id/toolbar"
        android:layout_width="0dp"
        android:layout_height="56dp"
        android:background="@color/toolbar_bg"
        android:elevation="4dp"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:gravity="center_vertical|end"
            android:orientation="horizontal"
            android:layoutDirection="rtl"
            android:paddingEnd="8dp"
            android:paddingStart="8dp">

            <ImageView
                android:id="@+id/toolbarLogo"
                android:layout_width="36dp"
                android:layout_height="36dp"
                android:src="@mipmap/ic_launcher"
                android:scaleType="fitCenter"
                android:layout_marginEnd="12dp"
                android:contentDescription="شعار التطبيق" />

            <TextView
                android:id="@+id/toolbarTitle"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:text="القرآن الكريم"
                android:textSize="18sp"
                android:textColor="@color/gold"
                android:textStyle="bold"
                android:fontFamily="serif" />

        </LinearLayout>

    </com.google.android.material.appbar.MaterialToolbar>

    <ProgressBar
        android:id="@+id/progressBar"
        style="@android:style/Widget.ProgressBar.Horizontal"
        android:layout_width="0dp"
        android:layout_height="3dp"
        android:max="100"
        android:progressTint="@color/gold"
        android:progressBackgroundTint="@android:color/transparent"
        android:visibility="gone"
        app:layout_constraintTop_toBottomOf="@id/toolbar"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <androidx.swiperefreshlayout.widget.SwipeRefreshLayout
        android:id="@+id/swipeRefresh"
        android:layout_width="0dp"
        android:layout_height="0dp"
        app:layout_constraintTop_toBottomOf="@id/progressBar"
        app:layout_constraintBottom_toTopOf="@id/bottomNav"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <WebView
            android:id="@+id/webView"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />

    </androidx.swiperefreshlayout.widget.SwipeRefreshLayout>

    <!-- Offline View -->
    <LinearLayout
        android:id="@+id/offlineView"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:orientation="vertical"
        android:gravity="center"
        android:background="@color/background"
        android:visibility="gone"
        android:clickable="true"
        android:focusable="true"
        app:layout_constraintTop_toBottomOf="@id/toolbar"
        app:layout_constraintBottom_toTopOf="@id/bottomNav"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <ImageView
            android:layout_width="120dp"
            android:layout_height="120dp"
            android:src="@drawable/splash_logo"
            android:alpha="0.5"
            android:contentDescription="غير متصل" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="لا يوجد اتصال بالإنترنت"
            android:textSize="18sp"
            android:textColor="@color/gold"
            android:layout_marginTop="24dp" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="اضغط هنا لإعادة المحاولة"
            android:textSize="14sp"
            android:textColor="@color/text_secondary"
            android:layout_marginTop="8dp" />

    </LinearLayout>

    <com.google.android.material.bottomnavigation.BottomNavigationView
        android:id="@+id/bottomNav"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:background="@color/toolbar_bg"
        app:itemIconTint="@color/bottom_nav_color"
        app:itemTextColor="@color/bottom_nav_color"
        app:labelVisibilityMode="labeled"
        app:menu="@menu/bottom_nav_menu"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
MAINLAYOUT

# Bottom navigation menu
mkdir -p $PROJECT/app/src/main/res/menu
cat > $PROJECT/app/src/main/res/menu/bottom_nav_menu.xml << 'MENU'
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:id="@+id/nav_quran"
        android:icon="@android:drawable/ic_menu_edit"
        android:title="القرآن" />
    <item
        android:id="@+id/nav_prayer"
        android:icon="@android:drawable/ic_menu_recent_history"
        android:title="الصلاة" />
    <item
        android:id="@+id/nav_qibla"
        android:icon="@android:drawable/ic_menu_compass"
        android:title="القبلة" />
    <item
        android:id="@+id/nav_bookmarks"
        android:icon="@android:drawable/ic_menu_save"
        android:title="المحفوظات" />
</menu>
MENU

# Bottom nav color selector
mkdir -p $PROJECT/app/src/main/res/color
cat > $PROJECT/app/src/main/res/color/bottom_nav_color.xml << 'NAVCOLOR'
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:color="#c8a84e" android:state_checked="true" />
    <item android:color="#80c8a84e" />
</selector>
NAVCOLOR

# colors.xml
cat > $PROJECT/app/src/main/res/values/colors.xml << 'COLORS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="background">#0a1628</color>
    <color name="toolbar_bg">#0f1f3a</color>
    <color name="splash_bg">#0a1628</color>
    <color name="gold">#c8a84e</color>
    <color name="green">#1a5c2e</color>
    <color name="card_bg">#16213e</color>
    <color name="text_primary">#f0e6d3</color>
    <color name="text_secondary">#a0b0c0</color>
    <color name="accent">#e2c275</color>
    <color name="status_bar">#060e1c</color>
</resources>
COLORS

# themes.xml
cat > $PROJECT/app/src/main/res/values/themes.xml << 'THEMES'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.QuranApp" parent="Theme.Material3.DayNight.NoActionBar">
        <item name="colorPrimary">@color/gold</item>
        <item name="colorPrimaryDark">@color/status_bar</item>
        <item name="colorAccent">@color/accent</item>
        <item name="android:windowBackground">@color/background</item>
        <item name="android:statusBarColor">@color/status_bar</item>
        <item name="android:navigationBarColor">@color/toolbar_bg</item>
        <item name="android:windowLightStatusBar">false</item>
    </style>

    <style name="Theme.QuranApp.Splash" parent="Theme.QuranApp">
        <item name="android:windowBackground">@color/splash_bg</item>
    </style>
</resources>
THEMES

# Night theme
cat > $PROJECT/app/src/main/res/values-night/themes.xml << 'NIGHTTHEME'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.QuranApp" parent="Theme.Material3.Dark.NoActionBar">
        <item name="colorPrimary">@color/gold</item>
        <item name="colorPrimaryDark">@color/status_bar</item>
        <item name="colorAccent">@color/accent</item>
        <item name="android:windowBackground">@color/background</item>
        <item name="android:statusBarColor">@color/status_bar</item>
        <item name="android:navigationBarColor">@color/toolbar_bg</item>
        <item name="android:windowLightStatusBar">false</item>
    </style>

    <style name="Theme.QuranApp.Splash" parent="Theme.QuranApp">
        <item name="android:windowBackground">@color/splash_bg</item>
    </style>
</resources>
NIGHTTHEME

# strings.xml
cat > $PROJECT/app/src/main/res/values/strings.xml << 'STRINGS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">القرآن الكريم</string>
</resources>
STRINGS

echo "✅ Native Quran Android project created successfully!"
echo "📱 Package: tech.meshari.quran"
echo "🎨 Icon: logoo.png from quran.meshari.tech"
echo "🚀 Version: 2.0.0 (versionCode 3)"
