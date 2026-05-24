#!/bin/bash
set -e

PROJECT="quran-app"
PKG="tech.meshari.quran"
PKG_PATH="tech/meshari/quran"

mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/data
mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/ui
mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/util
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
mkdir -p $PROJECT/app/src/main/res/menu
mkdir -p $PROJECT/app/src/main/res/color
mkdir -p $PROJECT/gradle/wrapper

# Logo
curl -sL "https://quran.meshari.tech/logoo.png" -o $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
for d in xxhdpi xhdpi hdpi mdpi; do
    cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-${d}/ic_launcher.png
    cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-${d}/ic_launcher_round.png
done
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/drawable/app_logo.png

cat > $PROJECT/settings.gradle.kts << 'SETTINGS'
pluginManagement {
    repositories { google(); mavenCentral(); gradlePluginPortal() }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories { google(); mavenCentral() }
}
rootProject.name = "QuranApp"
include(":app")
SETTINGS

cat > $PROJECT/build.gradle.kts << 'ROOTBUILD'
plugins {
    id("com.android.application") version "8.2.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}
ROOTBUILD

cat > $PROJECT/app/build.gradle.kts << 'APPBUILD'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}
android {
    namespace = "tech.meshari.quran"
    compileSdk = 35
    defaultConfig {
        applicationId = "tech.meshari.quran"
        minSdk = 24
        targetSdk = 35
        versionCode = 8
        versionName = "5.0.0"
    }
    buildFeatures { viewBinding = true }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"))
        }
    }
}
dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.recyclerview:recyclerview:1.3.2")
    implementation("androidx.cardview:cardview:1.0.0")
    implementation("androidx.viewpager2:viewpager2:1.0.0")
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:okhttp:4.12.0")
    implementation("com.github.bumptech.glide:glide:4.16.0")
    implementation("androidx.media:media:1.7.0")
    implementation("com.google.code.gson:gson:2.10.1")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.7.0")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.7.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
}
APPBUILD

cat > $PROJECT/app/src/main/AndroidManifest.xml << 'MANIFEST'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    <uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:label="القرآن الكريم"
        android:supportsRtl="true"
        android:theme="@style/AppTheme"
        android:usesCleartextTraffic="true">
        <activity android:name=".SplashActivity" android:exported="true" android:theme="@style/SplashTheme">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <activity android:name=".MainActivity" android:screenOrientation="portrait"/>
        <activity android:name=".AboutActivity" android:label="حول التطبيق" android:theme="@style/AppTheme" android:screenOrientation="portrait" />
    </application>
</manifest>
MANIFEST

cat > $PROJECT/app/src/main/res/values/colors.xml << 'COLORS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="bg">#FBF4E4</color>
    <color name="bg_card">#FCF7E8</color>
    <color name="bg_card_alt">#FDF9EC</color>
    <color name="card_stroke">#F2E7C9</color>
    <color name="bg_dark_card">#1A1F3A</color>
    <color name="bg_dark_card_2">#252A45</color>
    <color name="primary">#C8962F</color>
    <color name="primary_dark">#9C7C1C</color>
    <color name="gold">#D4A847</color>
    <color name="gold_light">#E8C977</color>
    <color name="gold_bg">#FAEED1</color>
    <color name="accent">#C8962F</color>
    <color name="text_primary">#2E2418</color>
    <color name="text_secondary">#9B8F77</color>
    <color name="text_gold">#B8860B</color>
    <color name="text_on_dark">#FFFFFF</color>
    <color name="text_on_dark_secondary">#A8B0C8</color>
    <color name="divider">#E8DCB8</color>
    <color name="meccan">#F4A549</color>
    <color name="meccan_bg">#FCEAD2</color>
    <color name="medinan">#5BB1E2</color>
    <color name="medinan_bg">#D7EBF7</color>
    <color name="adhkar_purple">#B4A6E2</color>
    <color name="adhkar_purple_bg">#E8E0FA</color>
    <color name="adhkar_orange">#F4B978</color>
    <color name="adhkar_orange_bg">#FDE5C8</color>
    <color name="adhkar_blue">#88BFE8</color>
    <color name="adhkar_blue_bg">#D7ECF8</color>
    <color name="adhkar_green">#83D69D</color>
    <color name="adhkar_green_bg">#D8F3DF</color>
    <color name="adhkar_pink">#D982C1</color>
    <color name="adhkar_pink_bg">#F5DBED</color>
    <color name="adhkar_yellow">#F4D26B</color>
    <color name="adhkar_yellow_bg">#FDF1C5</color>
    <color name="adhkar_teal">#7BCBC3</color>
    <color name="adhkar_teal_bg">#D2EEEB</color>
    <color name="adhkar_brown">#C9A584</color>
    <color name="adhkar_brown_bg">#F0E3D2</color>
    <color name="adhkar_mint">#A4D8C9</color>
    <color name="adhkar_mint_bg">#DFF0EA</color>
    <color name="adhkar_lavender">#C9B5E8</color>
    <color name="adhkar_lavender_bg">#EBE0F7</color>
    <color name="splash_bg">#FBF4E4</color>
    <color name="status_bar">#FBF4E4</color>
    <color name="nav_bar">#FFFDF6</color>
    <color name="nav_active">#C8962F</color>
    <color name="nav_inactive">#9B8F77</color>
    <color name="ripple_gold">#33D4A847</color>
    <color name="progress_track">#F0E5C9</color>
    <color name="streak_red">#E66B5A</color>
    <color name="stat_blue">#4FA3D9</color>
    <color name="stat_orange">#F4A549</color>
</resources>
COLORS

cat > $PROJECT/app/src/main/res/values/themes.xml << 'THEMES'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="AppTheme" parent="Theme.Material3.Light.NoActionBar">
        <item name="colorPrimary">@color/primary</item>
        <item name="colorPrimaryDark">@color/primary_dark</item>
        <item name="colorAccent">@color/accent</item>
        <item name="android:windowBackground">@color/bg</item>
        <item name="android:statusBarColor">@color/status_bar</item>
        <item name="android:navigationBarColor">@color/nav_bar</item>
        <item name="android:windowLightStatusBar">true</item>
        <item name="android:windowLightNavigationBar">true</item>
        <item name="android:textColor">@color/text_primary</item>
        <item name="android:fontFamily">sans-serif</item>
    </style>
    <style name="SplashTheme" parent="Theme.Material3.Light.NoActionBar">
        <item name="android:windowBackground">@color/splash_bg</item>
        <item name="android:statusBarColor">@color/splash_bg</item>
        <item name="android:navigationBarColor">@color/splash_bg</item>
        <item name="android:windowLightStatusBar">true</item>
    </style>
    <style name="GoldButton" parent="Widget.Material3.Button">
        <item name="backgroundTint">@color/primary</item>
        <item name="android:textColor">#FFFFFF</item>
        <item name="android:textSize">14sp</item>
        <item name="cornerRadius">22dp</item>
    </style>
    <style name="OutlineButton" parent="Widget.Material3.Button.OutlinedButton">
        <item name="strokeColor">@color/card_stroke</item>
        <item name="strokeWidth">1dp</item>
        <item name="android:textColor">@color/text_primary</item>
        <item name="cornerRadius">14dp</item>
    </style>
</resources>
THEMES

cat > $PROJECT/app/src/main/res/values/strings.xml << 'STRINGS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">القرآن الكريم</string>
    <string name="tab_home">الرئيسية</string>
    <string name="tab_quran">القرآن</string>
    <string name="tab_adhkar">أذكار وأدعية</string>
    <string name="tab_prayer">الصلاة</string>
    <string name="tab_more">المزيد</string>
    <string name="search_hint">ابحث في القرآن...</string>
    <string name="no_internet">لا يوجد اتصال بالإنترنت</string>
    <string name="loading">جاري التحميل...</string>
    <string name="retry">إعادة المحاولة</string>
    <string name="all">الكل</string>
    <string name="meccan">مكية</string>
    <string name="medinan">مدنية</string>
</resources>
STRINGS

cat > $PROJECT/app/src/main/res/menu/bottom_nav.xml << 'MENU'
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@+id/nav_home" android:icon="@drawable/ic_home" android:title="@string/tab_home"/>
    <item android:id="@+id/nav_quran" android:icon="@drawable/ic_quran" android:title="@string/tab_quran"/>
    <item android:id="@+id/nav_adhkar" android:icon="@drawable/ic_heart" android:title="@string/tab_adhkar"/>
    <item android:id="@+id/nav_prayer" android:icon="@drawable/ic_clock" android:title="@string/tab_prayer"/>
    <item android:id="@+id/nav_more" android:icon="@drawable/ic_grid" android:title="@string/tab_more"/>
</menu>
MENU

cat > $PROJECT/app/src/main/res/color/bottom_nav_colors.xml << 'NAVCOLORS'
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_checked="true" android:color="@color/nav_active"/>
    <item android:color="@color/nav_inactive"/>
</selector>
NAVCOLORS

echo "✅ Base infrastructure written"

# ========== DRAWABLES ==========
cat > $PROJECT/app/src/main/res/drawable/card_bg.xml << 'D1'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_card"/>
    <corners android:radius="22dp"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D1

cat > $PROJECT/app/src/main/res/drawable/card_bg_inner.xml << 'D2'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_card_alt"/>
    <corners android:radius="18dp"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D2

cat > $PROJECT/app/src/main/res/drawable/card_bg_dark.xml << 'D3'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_dark_card"/>
    <corners android:radius="22dp"/>
</shape>
D3

cat > $PROJECT/app/src/main/res/drawable/circle_gold.xml << 'D4'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="@color/gold_bg"/>
    <stroke android:width="1dp" android:color="@color/gold_light"/>
</shape>
D4

cat > $PROJECT/app/src/main/res/drawable/circle_white.xml << 'D5'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="#FFFFFF"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D5

cat > $PROJECT/app/src/main/res/drawable/circle_purple.xml << 'D6'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="@color/adhkar_purple_bg"/>
</shape>
D6
cat > $PROJECT/app/src/main/res/drawable/circle_orange.xml << 'D7'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_orange_bg"/></shape>
D7
cat > $PROJECT/app/src/main/res/drawable/circle_blue.xml << 'D8'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_blue_bg"/></shape>
D8
cat > $PROJECT/app/src/main/res/drawable/circle_green.xml << 'D9'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_green_bg"/></shape>
D9
cat > $PROJECT/app/src/main/res/drawable/circle_pink.xml << 'D10'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_pink_bg"/></shape>
D10
cat > $PROJECT/app/src/main/res/drawable/circle_yellow.xml << 'D11'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_yellow_bg"/></shape>
D11
cat > $PROJECT/app/src/main/res/drawable/circle_teal.xml << 'D12'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_teal_bg"/></shape>
D12
cat > $PROJECT/app/src/main/res/drawable/circle_brown.xml << 'D13'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_brown_bg"/></shape>
D13
cat > $PROJECT/app/src/main/res/drawable/circle_mint.xml << 'D14'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_mint_bg"/></shape>
D14
cat > $PROJECT/app/src/main/res/drawable/circle_lavender.xml << 'D15'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="@color/adhkar_lavender_bg"/></shape>
D15

cat > $PROJECT/app/src/main/res/drawable/badge_meccan.xml << 'D16'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/meccan_bg"/>
    <corners android:radius="10dp"/>
</shape>
D16

cat > $PROJECT/app/src/main/res/drawable/badge_medinan.xml << 'D17'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/medinan_bg"/>
    <corners android:radius="10dp"/>
</shape>
D17

cat > $PROJECT/app/src/main/res/drawable/filter_active.xml << 'D18'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/primary"/>
    <corners android:radius="22dp"/>
</shape>
D18

cat > $PROJECT/app/src/main/res/drawable/filter_inactive.xml << 'D19'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="#00000000"/>
    <corners android:radius="22dp"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D19

cat > $PROJECT/app/src/main/res/drawable/search_bg.xml << 'D20'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_card"/>
    <corners android:radius="14dp"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D20

cat > $PROJECT/app/src/main/res/drawable/star_badge.xml << 'D21'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="48dp" android:height="48dp" android:viewportWidth="48" android:viewportHeight="48">
    <path android:fillColor="#FAEED1" android:strokeColor="#E8C977" android:strokeWidth="1"
        android:pathData="M24,2 L29,8 L37,5 L38,13 L46,16 L42,23 L46,30 L38,33 L37,41 L29,38 L24,44 L19,38 L11,41 L10,33 L2,30 L6,23 L2,16 L10,13 L11,5 L19,8 Z"/>
</vector>
D21

cat > $PROJECT/app/src/main/res/drawable/progress_bg.xml << 'D22'
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@android:id/background">
        <shape><solid android:color="@color/progress_track"/><corners android:radius="3dp"/></shape>
    </item>
    <item android:id="@android:id/progress">
        <clip><shape><solid android:color="@color/primary"/><corners android:radius="3dp"/></shape></clip>
    </item>
</layer-list>
D22

cat > $PROJECT/app/src/main/res/drawable/progress_bg_dark.xml << 'D23'
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@android:id/background">
        <shape><solid android:color="#333852"/><corners android:radius="3dp"/></shape>
    </item>
    <item android:id="@android:id/progress">
        <clip><shape><solid android:color="@color/stat_blue"/><corners android:radius="3dp"/></shape></clip>
    </item>
</layer-list>
D23

# ===== Vector icons =====
cat > $PROJECT/app/src/main/res/drawable/ic_home.xml << 'I1'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="?attr/colorControlNormal">
    <path android:fillColor="@android:color/white" android:pathData="M12,3L2,12h3v8h6v-6h2v6h6v-8h3L12,3z"/>
</vector>
I1

cat > $PROJECT/app/src/main/res/drawable/ic_quran.xml << 'I2'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="?attr/colorControlNormal">
    <path android:fillColor="@android:color/white" android:pathData="M21,5c-1.11,-0.35 -2.33,-0.5 -3.5,-0.5c-1.95,0 -4.05,0.4 -5.5,1.5c-1.45,-1.1 -3.55,-1.5 -5.5,-1.5S2.45,4.9 1,6v14.65c0,0.25 0.25,0.5 0.5,0.5c0.1,0 0.15,-0.05 0.25,-0.05C3.1,20.45 5.05,20 6.5,20c1.95,0 4.05,0.4 5.5,1.5c1.35,-0.85 3.8,-1.5 5.5,-1.5c1.65,0 3.35,0.3 4.75,1.05c0.1,0.05 0.15,0.05 0.25,0.05c0.25,0 0.5,-0.25 0.5,-0.5V6C22.4,5.55 21.75,5.25 21,5z"/>
</vector>
I2

cat > $PROJECT/app/src/main/res/drawable/ic_heart.xml << 'I3'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="?attr/colorControlNormal">
    <path android:fillColor="@android:color/white" android:pathData="M12,21.35l-1.45,-1.32C5.4,15.36 2,12.28 2,8.5C2,5.42 4.42,3 7.5,3c1.74,0 3.41,0.81 4.5,2.09C13.09,3.81 14.76,3 16.5,3C19.58,3 22,5.42 22,8.5c0,3.78 -3.4,6.86 -8.55,11.54L12,21.35z"/>
</vector>
I3

cat > $PROJECT/app/src/main/res/drawable/ic_clock.xml << 'I4'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="?attr/colorControlNormal">
    <path android:fillColor="@android:color/white" android:pathData="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4M12.5,7V12.25L17,14.92L16.25,16.15L11,13V7H12.5Z"/>
</vector>
I4

cat > $PROJECT/app/src/main/res/drawable/ic_grid.xml << 'I5'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="?attr/colorControlNormal">
    <path android:fillColor="@android:color/white" android:pathData="M4,4h6v6H4V4zM14,4h6v6h-6V4zM4,14h6v6H4V14zM14,14h6v6h-6V14z"/>
</vector>
I5

cat > $PROJECT/app/src/main/res/drawable/ic_bell.xml << 'I6'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/primary">
    <path android:fillColor="@android:color/white" android:pathData="M12,22c1.1,0 2,-0.9 2,-2h-4C10,21.1 10.9,22 12,22zM18,16v-5c0,-3.07 -1.63,-5.64 -4.5,-6.32V4c0,-0.83 -0.67,-1.5 -1.5,-1.5s-1.5,0.67 -1.5,1.5v0.68C7.64,5.36 6,7.92 6,11v5l-2,2v1h16v-1L18,16z"/>
</vector>
I6

cat > $PROJECT/app/src/main/res/drawable/ic_compass.xml << 'I7'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/stat_blue">
    <path android:fillColor="@android:color/white" android:pathData="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M14.19,14.19L6,18L9.81,9.81L18,6L14.19,14.19M12,11A1,1 0 0,0 11,12A1,1 0 0,0 12,13A1,1 0 0,0 13,12A1,1 0 0,0 12,11Z"/>
</vector>
I7

cat > $PROJECT/app/src/main/res/drawable/ic_moon.xml << 'I8'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/stat_blue">
    <path android:fillColor="@android:color/white" android:pathData="M17.75,4.09L15.22,6.03L16.13,9.09L13.5,7.28L10.87,9.09L11.78,6.03L9.25,4.09L12.44,4L13.5,1L14.56,4L17.75,4.09M21.25,11L19.61,12.25L20.2,14.23L18.5,13.06L16.8,14.23L17.39,12.25L15.75,11L17.81,10.95L18.5,9L19.19,10.95L21.25,11M18.97,15.95C19.8,15.87 20.69,17.05 20.16,17.8C19.84,18.25 19.5,18.67 19.08,19.07C15.17,23 8.84,23 4.94,19.07C1.03,15.17 1.03,8.83 4.94,4.93C5.34,4.53 5.76,4.17 6.21,3.85C6.96,3.32 8.14,4.21 8.06,5.04C7.79,7.9 8.75,10.87 10.95,13.06C13.14,15.26 16.1,16.22 18.97,15.95M17.33,17.97C14.5,17.81 11.7,16.64 9.53,14.5C7.36,12.31 6.2,9.5 6.04,6.68C3.23,9.82 3.34,14.4 6.35,17.41C9.37,20.43 14,20.54 17.33,17.97Z"/>
</vector>
I8

cat > $PROJECT/app/src/main/res/drawable/ic_book.xml << 'I9'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/text_secondary">
    <path android:fillColor="@android:color/white" android:pathData="M21,4H3C1.9,4 1,4.9 1,6v12c0,1.1 0.9,2 2,2h18c1.1,0 1.99,-0.9 1.99,-2L23,6C23,4.9 22.1,4 21,4zM21,18H3V8h18V18z"/>
</vector>
I9

cat > $PROJECT/app/src/main/res/drawable/ic_back.xml << 'I10'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/text_primary">
    <path android:fillColor="@android:color/white" android:pathData="M8.59,16.59L13.17,12L8.59,7.41L10,6l6,6 -6,6 -1.41,-1.41z"/>
</vector>
I10

cat > $PROJECT/app/src/main/res/drawable/ic_reset.xml << 'I11'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/primary">
    <path android:fillColor="@android:color/white" android:pathData="M17.65,6.35C16.2,4.9 14.21,4 12,4c-4.42,0 -7.99,3.58 -7.99,8s3.57,8 7.99,8c3.73,0 6.84,-2.55 7.73,-6h-2.08c-0.82,2.33 -3.04,4 -5.65,4 -3.31,0 -6,-2.69 -6,-6s2.69,-6 6,-6c1.66,0 3.14,0.69 4.22,1.78L13,11h7V4l-2.35,2.35z"/>
</vector>
I11

cat > $PROJECT/app/src/main/res/drawable/ic_search.xml << 'I12'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/primary">
    <path android:fillColor="@android:color/white" android:pathData="M15.5,14h-0.79l-0.28,-0.27C15.41,12.59 16,11.11 16,9.5 16,5.91 13.09,3 9.5,3S3,5.91 3,9.5 5.91,16 9.5,16c1.61,0 3.09,-0.59 4.23,-1.57l0.27,0.28v0.79l5,4.99L20.49,19l-4.99,-5zM9.5,14C7.01,14 5,11.99 5,9.5S7.01,5 9.5,5 14,7.01 14,9.5 11.99,14 9.5,14z"/>
</vector>
I12

cat > $PROJECT/app/src/main/res/drawable/ic_location.xml << 'I13'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/primary">
    <path android:fillColor="@android:color/white" android:pathData="M12,2C8.13,2 5,5.13 5,9c0,5.25 7,13 7,13s7,-7.75 7,-13c0,-3.87 -3.13,-7 -7,-7zM12,11.5c-1.38,0 -2.5,-1.12 -2.5,-2.5s1.12,-2.5 2.5,-2.5 2.5,1.12 2.5,2.5 -1.12,2.5 -2.5,2.5z"/>
</vector>
I13

cat > $PROJECT/app/src/main/res/drawable/ic_chevron_left.xml << 'I14'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/text_secondary">
    <path android:fillColor="@android:color/white" android:pathData="M15.41,16.59L10.83,12l4.58,-4.59L14,6l-6,6 6,6 1.41,-1.41z"/>
</vector>
I14

cat > $PROJECT/app/src/main/res/drawable/ic_flame.xml << 'I15'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/streak_red">
    <path android:fillColor="@android:color/white" android:pathData="M13.5,0.67c0,0 0.74,2.65 0.74,4.8c0,2.06 -1.35,3.73 -3.41,3.73c-2.07,0 -3.63,-1.67 -3.63,-3.73l0.03,-0.36C5.21,7.51 4,10.62 4,14c0,4.42 3.58,8 8,8s8,-3.58 8,-8C20,8.61 17.41,3.8 13.5,0.67zM11.71,19c-1.78,0 -3.22,-1.4 -3.22,-3.14c0,-1.62 1.05,-2.76 2.81,-3.12c1.77,-0.36 3.6,-1.21 4.62,-2.58c0.39,1.29 0.59,2.65 0.59,4.04C16.5,16.88 14.36,19 11.71,19z"/>
</vector>
I15

cat > $PROJECT/app/src/main/res/drawable/ic_calendar.xml << 'I16'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/stat_blue">
    <path android:fillColor="@android:color/white" android:pathData="M19,3h-1V1h-2v2H8V1H6v2H5C3.89,3 3.01,3.9 3.01,5L3,19c0,1.1 0.89,2 2,2h14c1.1,0 2,-0.9 2,-2V5C21,3.9 20.1,3 19,3zM19,19H5V8h14V19zM7,10h5v5H7z"/>
</vector>
I16

cat > $PROJECT/app/src/main/res/drawable/ic_sun.xml << 'I17'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/stat_orange">
    <path android:fillColor="@android:color/white" android:pathData="M12,7c-2.76,0 -5,2.24 -5,5s2.24,5 5,5 5,-2.24 5,-5 -2.24,-5 -5,-5zM2,13h2c0.55,0 1,-0.45 1,-1s-0.45,-1 -1,-1H2c-0.55,0 -1,0.45 -1,1s0.45,1 1,1zM20,13h2c0.55,0 1,-0.45 1,-1s-0.45,-1 -1,-1h-2c-0.55,0 -1,0.45 -1,1s0.45,1 1,1zM11,2v2c0,0.55 0.45,1 1,1s1,-0.45 1,-1V2c0,-0.55 -0.45,-1 -1,-1s-1,0.45 -1,1zM11,20v2c0,0.55 0.45,1 1,1s1,-0.45 1,-1v-2c0,-0.55 -0.45,-1 -1,-1s-1,0.45 -1,1zM5.99,4.58c-0.39,-0.39 -1.03,-0.39 -1.41,0 -0.39,0.39 -0.39,1.03 0,1.41l1.06,1.06c0.39,0.39 1.03,0.39 1.41,0s0.39,-1.03 0,-1.41L5.99,4.58zM18.36,16.95c-0.39,-0.39 -1.03,-0.39 -1.41,0 -0.39,0.39 -0.39,1.03 0,1.41l1.06,1.06c0.39,0.39 1.03,0.39 1.41,0 0.39,-0.39 0.39,-1.03 0,-1.41l-1.06,-1.06zM19.42,5.99c0.39,-0.39 0.39,-1.03 0,-1.41 -0.39,-0.39 -1.03,-0.39 -1.41,0l-1.06,1.06c-0.39,0.39 -0.39,1.03 0,1.41s1.03,0.39 1.41,0l1.06,-1.06zM7.05,18.36c0.39,-0.39 0.39,-1.03 0,-1.41 -0.39,-0.39 -1.03,-0.39 -1.41,0l-1.06,1.06c-0.39,0.39 -0.39,1.03 0,1.41s1.03,0.39 1.41,0l1.06,-1.06z"/>
</vector>
I17

cat > $PROJECT/app/src/main/res/drawable/ic_play.xml << 'I18'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="#FFFFFF">
    <path android:fillColor="@android:color/white" android:pathData="M8,5v14l11,-7z"/>
</vector>
I18

cat > $PROJECT/app/src/main/res/drawable/ic_pause.xml << 'I19'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="#FFFFFF">
    <path android:fillColor="@android:color/white" android:pathData="M6,19h4V5H6v14zm8,-14v14h4V5h-4z"/>
</vector>
I19

cat > $PROJECT/app/src/main/res/drawable/ic_prev.xml << 'I20'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/text_primary">
    <path android:fillColor="@android:color/white" android:pathData="M6,6h2v12H6zM9.5,12l8.5,6V6z"/>
</vector>
I20

cat > $PROJECT/app/src/main/res/drawable/ic_next.xml << 'I21'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/text_primary">
    <path android:fillColor="@android:color/white" android:pathData="M6,18l8.5,-6L6,6v12zM16,6v12h2V6h-2z"/>
</vector>
I21

cat > $PROJECT/app/src/main/res/drawable/ic_info.xml << 'I22'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/primary">
    <path android:fillColor="@android:color/white" android:pathData="M11,7h2v2h-2zM11,11h2v6h-2zM12,2C6.48,2 2,6.48 2,12s4.48,10 10,10 10,-4.48 10,-10S17.52,2 12,2zM12,20c-4.41,0 -8,-3.59 -8,-8s3.59,-8 8,-8 8,3.59 8,8 -3.59,8 -8,8z"/>
</vector>
I22

cat > $PROJECT/app/src/main/res/drawable/ic_dot.xml << 'I23'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="8dp" android:height="8dp" android:viewportWidth="8" android:viewportHeight="8" android:tint="@color/adhkar_green">
    <path android:fillColor="@android:color/white" android:pathData="M4,1 A3,3 0 1,1 4,7 A3,3 0 1,1 4,1 Z"/>
</vector>
I23

cat > $PROJECT/app/src/main/res/drawable/play_btn_bg.xml << 'D24'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="@color/primary"/>
</shape>
D24

cat > $PROJECT/app/src/main/res/drawable/reset_btn_bg.xml << 'D25'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_card"/>
    <corners android:radius="20dp"/>
    <stroke android:width="1dp" android:color="@color/card_stroke"/>
</shape>
D25

cat > $PROJECT/app/src/main/res/drawable/dhikr_progress.xml << 'D26'
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@android:id/background">
        <shape><solid android:color="@color/progress_track"/><corners android:radius="2dp"/></shape>
    </item>
    <item android:id="@android:id/progress">
        <clip><shape><solid android:color="@color/primary"/><corners android:radius="2dp"/></shape></clip>
    </item>
</layer-list>
D26

cat > $PROJECT/app/src/main/res/drawable/circle_dark.xml << 'D27'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="@color/bg_dark_card_2"/>
</shape>
D27

echo "✅ Drawables written"

# ========== LAYOUTS ==========
cat > $PROJECT/app/src/main/res/layout/activity_splash.xml << 'L1'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:background="@color/splash_bg">
    <ImageView android:id="@+id/splashLogo" android:layout_width="180dp" android:layout_height="180dp"
        android:src="@drawable/app_logo" android:alpha="0"/>
    <TextView android:id="@+id/splashTitle" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="القرآن الكريم" android:textColor="@color/primary" android:textSize="32sp"
        android:textStyle="bold" android:layout_marginTop="24dp" android:alpha="0"/>
    <TextView android:id="@+id/splashSubtitle" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="quran.meshari.tech" android:textColor="@color/text_secondary" android:textSize="14sp"
        android:layout_marginTop="8dp" android:alpha="0"/>
</LinearLayout>
L1

cat > $PROJECT/app/src/main/res/layout/activity_main.xml << 'L2'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg">
    <FrameLayout android:id="@+id/fragmentContainer"
        android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"/>
    <com.google.android.material.bottomnavigation.BottomNavigationView android:id="@+id/bottomNav"
        android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/nav_bar"
        app:itemTextColor="@color/bottom_nav_colors"
        app:itemIconTint="@color/bottom_nav_colors"
        app:itemActiveIndicatorStyle="@style/Widget.Material3.BottomNavigationView.ActiveIndicator"
        app:labelVisibilityMode="labeled" app:menu="@menu/bottom_nav"/>
</LinearLayout>
L2

cat > $PROJECT/app/src/main/res/layout/fragment_home.xml << 'L3'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:background="@color/bg" android:fillViewport="true">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:paddingStart="16dp" android:paddingEnd="16dp"
        android:paddingTop="16dp" android:paddingBottom="24dp">

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="center_vertical" android:paddingBottom="20dp">
            <ImageView android:layout_width="44dp" android:layout_height="44dp"
                android:src="@drawable/app_logo" android:background="@drawable/circle_gold" android:padding="4dp"/>
            <ImageView android:id="@+id/homeBell" android:layout_width="44dp" android:layout_height="44dp"
                android:src="@drawable/ic_bell" android:background="@drawable/circle_white" android:padding="10dp"
                android:layout_marginStart="10dp"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="end">
                <TextView android:id="@+id/homeGreeting" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="تصبح على خير 🌙" android:textColor="@color/text_primary"
                    android:textSize="22sp" android:textStyle="bold"/>
                <TextView android:id="@+id/homeHijri" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:textColor="@color/text_secondary" android:textSize="13sp"
                    android:layout_marginTop="4dp" android:text="📅 ..."/>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="vertical" android:background="@drawable/card_bg"
            android:padding="18dp" android:layout_marginBottom="14dp">
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="8dp">
                <View android:layout_width="8dp" android:layout_height="8dp"
                    android:background="@drawable/ic_dot"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="الصلاة القادمة" android:textColor="@color/text_primary"
                    android:textSize="14sp" android:textStyle="bold" android:layout_marginStart="8dp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical" android:paddingTop="8dp">
                <LinearLayout android:layout_width="64dp" android:layout_height="64dp"
                    android:background="@drawable/circle_gold" android:gravity="center"
                    android:orientation="vertical">
                    <ImageView android:id="@+id/homeNextPrayerIcon" android:layout_width="32dp" android:layout_height="32dp"
                        android:src="@drawable/ic_moon"/>
                </LinearLayout>
                <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
                <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:orientation="vertical" android:gravity="center">
                    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="بقي على الصلاة" android:textColor="@color/text_secondary"
                        android:textSize="13sp" android:gravity="center"/>
                    <TextView android:id="@+id/homePrayerCountdown" android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="--:--" android:textColor="@color/primary"
                        android:textSize="36sp" android:textStyle="bold" android:layout_marginTop="4dp" android:gravity="center"/>
                </LinearLayout>
                <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
                <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:orientation="vertical" android:gravity="center">
                    <TextView android:id="@+id/homeNextPrayerName" android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="الفجر" android:textColor="@color/text_primary"
                        android:textSize="18sp" android:textStyle="bold"/>
                    <TextView android:id="@+id/homeNextPrayerTime" android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="--:--" android:textColor="@color/text_secondary"
                        android:textSize="13sp" android:layout_marginTop="2dp"/>
                </LinearLayout>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:id="@+id/homeQiblaCard" android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:background="@drawable/card_bg"
            android:padding="16dp" android:gravity="center_vertical" android:layout_marginBottom="14dp">
            <ImageView android:layout_width="20dp" android:layout_height="20dp" android:src="@drawable/ic_chevron_left"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="end" android:paddingEnd="14dp">
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="البوصلة" android:textColor="@color/text_primary"
                    android:textSize="16sp" android:textStyle="bold"/>
                <TextView android:id="@+id/homeQiblaText" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="اتجاه القبلة — حرّك جهازك" android:textColor="@color/text_secondary"
                    android:textSize="12sp" android:layout_marginTop="4dp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="56dp" android:layout_height="56dp"
                android:background="@drawable/circle_blue" android:gravity="center">
                <ImageView android:layout_width="32dp" android:layout_height="32dp" android:src="@drawable/ic_compass"/>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="vertical" android:background="@drawable/card_bg"
            android:padding="16dp" android:layout_marginBottom="14dp">
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="end|center_vertical">
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="📖 آخر موقف قراءة" android:textColor="@color/text_primary"
                    android:textSize="15sp" android:textStyle="bold"/>
            </LinearLayout>
            <LinearLayout android:id="@+id/homeLastReadRow" android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical" android:paddingTop="12dp">
                <ImageView android:layout_width="40dp" android:layout_height="40dp" android:src="@drawable/ic_book"/>
                <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
                <TextView android:id="@+id/homeLastReadText" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="لم تبدأ القراءة بعد — افتح أي سورة لتبدأ"
                    android:textColor="@color/text_secondary" android:textSize="13sp"/>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="vertical" android:background="@drawable/card_bg_dark"
            android:padding="18dp" android:layout_marginBottom="14dp">
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="10dp">
                <ImageView android:layout_width="20dp" android:layout_height="20dp" android:src="@drawable/ic_moon"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="حالة القمر" android:textColor="@color/text_on_dark_secondary"
                    android:textSize="14sp" android:layout_marginStart="8dp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical">
                <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
                    android:layout_weight="1" android:orientation="vertical">
                    <TextView android:id="@+id/homeMoonNameAr" android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="هلال متزايد" android:textColor="@color/gold"
                        android:textSize="22sp" android:textStyle="bold"/>
                    <TextView android:id="@+id/homeMoonNameEn" android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="Waxing Crescent" android:textColor="@color/text_on_dark_secondary"
                        android:textSize="13sp" android:layout_marginTop="2dp"/>
                    <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginTop="14dp">
                        <TextView android:id="@+id/homeMoonIllum" android:layout_width="wrap_content" android:layout_height="wrap_content"
                            android:text="19%" android:textColor="@color/gold"
                            android:textSize="20sp" android:textStyle="bold"/>
                        <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                            android:text="الإضاءة" android:textColor="@color/text_on_dark_secondary"
                            android:textSize="11sp" android:layout_marginStart="4dp"/>
                        <Space android:layout_width="14dp" android:layout_height="0dp"/>
                        <TextView android:id="@+id/homeMoonDay" android:layout_width="wrap_content" android:layout_height="wrap_content"
                            android:text="4" android:textColor="@color/gold"
                            android:textSize="20sp" android:textStyle="bold"/>
                        <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                            android:text="يوم هجري" android:textColor="@color/text_on_dark_secondary"
                            android:textSize="11sp" android:layout_marginStart="4dp"/>
                    </LinearLayout>
                </LinearLayout>
                <ImageView android:layout_width="80dp" android:layout_height="80dp" android:src="@drawable/ic_moon"/>
            </LinearLayout>
            <ProgressBar android:id="@+id/homeMoonProgress" style="?android:attr/progressBarStyleHorizontal"
                android:layout_width="match_parent" android:layout_height="6dp"
                android:max="100" android:progress="19" android:progressDrawable="@drawable/progress_bg_dark"
                android:layout_marginTop="14dp"/>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:background="@drawable/card_bg"
            android:padding="14dp" android:weightSum="4">
            <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
                android:layout_weight="1" android:orientation="vertical" android:gravity="center">
                <ImageView android:layout_width="22dp" android:layout_height="22dp" android:src="@drawable/ic_quran"/>
                <TextView android:id="@+id/statTotal" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="0" android:textColor="@color/text_primary" android:textSize="20sp"
                    android:textStyle="bold" android:layout_marginTop="6dp"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="إجمالي" android:textColor="@color/text_secondary" android:textSize="11sp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
                android:layout_weight="1" android:orientation="vertical" android:gravity="center">
                <ImageView android:layout_width="22dp" android:layout_height="22dp" android:src="@drawable/ic_flame"/>
                <TextView android:id="@+id/statStreak" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="0" android:textColor="@color/text_primary" android:textSize="20sp"
                    android:textStyle="bold" android:layout_marginTop="6dp"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="أيام متتالية" android:textColor="@color/text_secondary" android:textSize="11sp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
                android:layout_weight="1" android:orientation="vertical" android:gravity="center">
                <ImageView android:layout_width="22dp" android:layout_height="22dp" android:src="@drawable/ic_calendar"/>
                <TextView android:id="@+id/statWeek" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="0" android:textColor="@color/text_primary" android:textSize="20sp"
                    android:textStyle="bold" android:layout_marginTop="6dp"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="هذا الأسبوع" android:textColor="@color/text_secondary" android:textSize="11sp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
                android:layout_weight="1" android:orientation="vertical" android:gravity="center">
                <ImageView android:layout_width="22dp" android:layout_height="22dp" android:src="@drawable/ic_sun"/>
                <TextView android:id="@+id/statToday" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="0" android:textColor="@color/text_primary" android:textSize="20sp"
                    android:textStyle="bold" android:layout_marginTop="6dp"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="صفحات اليوم" android:textColor="@color/text_secondary" android:textSize="11sp"/>
            </LinearLayout>
        </LinearLayout>

    </LinearLayout>
</ScrollView>
L3

echo "✅ Home layout written"

cat > $PROJECT/app/src/main/res/layout/fragment_surah_list.xml << 'L4'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:paddingStart="20dp" android:paddingEnd="20dp"
        android:paddingTop="20dp" android:paddingBottom="14dp">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="center_vertical">
            <ImageView android:id="@+id/btnQuranSearch" android:layout_width="32dp" android:layout_height="32dp"
                android:src="@drawable/ic_search"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="center">
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="القرآن الكريم" android:textColor="@color/primary"
                    android:textSize="24sp" android:textStyle="bold"/>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="114 سورة • 604 صفحة" android:textColor="@color/text_secondary"
                    android:textSize="12sp" android:layout_marginTop="2dp"/>
            </LinearLayout>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <View android:layout_width="32dp" android:layout_height="32dp"/>
        </LinearLayout>
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content"
            android:text="بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ" android:textColor="@color/primary"
            android:textSize="18sp" android:gravity="center" android:layout_marginTop="10dp"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="end|center_vertical" android:layout_marginTop="14dp">
            <TextView android:id="@+id/surahCountText" android:layout_width="0dp" android:layout_height="wrap_content"
                android:layout_weight="1" android:text="114 سورة"
                android:textColor="@color/text_secondary" android:textSize="13sp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnMedinan"
                android:layout_width="wrap_content" android:layout_height="36dp"
                android:text="مدنية" android:textSize="13sp" android:textColor="@color/text_primary"
                android:backgroundTint="@android:color/transparent"
                app:strokeColor="@color/card_stroke" app:strokeWidth="1dp" app:cornerRadius="20dp"
                android:minWidth="0dp" android:layout_marginStart="6dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnMeccan"
                android:layout_width="wrap_content" android:layout_height="36dp"
                android:text="مكية" android:textSize="13sp" android:textColor="@color/text_primary"
                android:backgroundTint="@android:color/transparent"
                app:strokeColor="@color/card_stroke" app:strokeWidth="1dp" app:cornerRadius="20dp"
                android:minWidth="0dp" android:layout_marginStart="6dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnAll"
                android:layout_width="wrap_content" android:layout_height="36dp"
                android:text="الكل" android:textSize="13sp" android:textColor="#FFFFFF"
                android:backgroundTint="@color/primary"
                app:cornerRadius="20dp" android:minWidth="0dp" android:layout_marginStart="6dp"
                android:insetTop="0dp" android:insetBottom="0dp"/>
        </LinearLayout>
    </LinearLayout>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/surahRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent"
        android:paddingStart="16dp" android:paddingEnd="16dp" android:paddingBottom="16dp"
        android:clipToPadding="false"/>
</LinearLayout>
L4

cat > $PROJECT/app/src/main/res/layout/item_surah.xml << 'L5'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="wrap_content"
    android:orientation="horizontal" android:gravity="center_vertical"
    android:background="@drawable/card_bg" android:padding="14dp" android:layout_marginBottom="8dp">
    <ImageView android:layout_width="20dp" android:layout_height="20dp" android:src="@drawable/ic_chevron_left"/>
    <TextView android:id="@+id/surahNameEn" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textColor="@color/text_secondary" android:textSize="13sp" android:layout_marginStart="8dp"/>
    <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
    <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:orientation="vertical" android:gravity="end" android:paddingEnd="12dp">
        <TextView android:id="@+id/surahNameAr" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/text_primary" android:textSize="20sp" android:textStyle="bold"/>
        <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="end|center_vertical" android:layout_marginTop="4dp">
            <TextView android:id="@+id/surahAyahs" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_secondary" android:textSize="12sp"/>
            <TextView android:id="@+id/surahType" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textSize="11sp" android:paddingStart="8dp" android:paddingEnd="8dp"
                android:paddingTop="3dp" android:paddingBottom="3dp" android:layout_marginStart="8dp"/>
        </LinearLayout>
    </LinearLayout>
    <FrameLayout android:layout_width="52dp" android:layout_height="52dp">
        <ImageView android:layout_width="52dp" android:layout_height="52dp" android:src="@drawable/star_badge"/>
        <TextView android:id="@+id/surahNumber" android:layout_width="match_parent" android:layout_height="match_parent"
            android:gravity="center" android:textColor="@color/primary"
            android:textSize="15sp" android:textStyle="bold"/>
    </FrameLayout>
</LinearLayout>
L5

cat > $PROJECT/app/src/main/res/layout/fragment_reader.xml << 'L6'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/bg" android:padding="14dp" android:gravity="center_vertical"
        android:orientation="horizontal">
        <ImageView android:id="@+id/btnBack" android:layout_width="36dp" android:layout_height="36dp"
            android:src="@drawable/ic_back" android:padding="6dp"/>
        <TextView android:id="@+id/surahTitle" android:layout_width="0dp" android:layout_height="wrap_content"
            android:layout_weight="1" android:textColor="@color/primary" android:textSize="20sp"
            android:textStyle="bold" android:gravity="center"/>
        <TextView android:id="@+id/pageInfo" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/text_secondary" android:textSize="12sp"/>
    </LinearLayout>
    <FrameLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"
        android:background="@color/bg">
        <ImageView android:id="@+id/quranPageImage" android:layout_width="match_parent"
            android:layout_height="match_parent" android:scaleType="fitCenter" android:background="#FFFFF8E1"/>
        <ProgressBar android:id="@+id/pageLoading" android:layout_width="48dp" android:layout_height="48dp"
            android:layout_gravity="center" android:indeterminateTint="@color/primary"/>
    </FrameLayout>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/bg_card" android:padding="8dp" android:gravity="center"
        android:orientation="horizontal">
        <ImageView android:id="@+id/btnNext" android:layout_width="44dp" android:layout_height="44dp"
            android:src="@drawable/ic_prev" android:padding="10dp"/>
        <Spinner android:id="@+id/reciterSpinner" android:layout_width="0dp" android:layout_height="40dp"
            android:layout_weight="1" android:layout_marginStart="8dp" android:layout_marginEnd="4dp"
            android:background="@drawable/search_bg"/>
        <ImageView android:id="@+id/btnPlay" android:layout_width="48dp" android:layout_height="48dp"
            android:src="@drawable/ic_play" android:padding="12dp" android:background="@drawable/play_btn_bg"/>
        <ImageView android:id="@+id/btnTafsir" android:layout_width="44dp" android:layout_height="44dp"
            android:src="@drawable/ic_info" android:padding="10dp" android:layout_marginStart="4dp"/>
        <ImageView android:id="@+id/btnPrev" android:layout_width="44dp" android:layout_height="44dp"
            android:src="@drawable/ic_next" android:padding="10dp"/>
    </LinearLayout>
</LinearLayout>
L6

cat > $PROJECT/app/src/main/res/layout/fragment_prayer.xml << 'L7'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:background="@color/bg">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:paddingStart="16dp" android:paddingEnd="16dp"
        android:paddingTop="16dp" android:paddingBottom="24dp">

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="center_vertical" android:paddingBottom="14dp">
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="horizontal" android:gravity="center_vertical">
                <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:orientation="horizontal" android:background="@drawable/circle_orange"
                    android:padding="8dp" android:gravity="center">
                    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="🔔" android:textSize="14sp"/>
                </LinearLayout>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="صوت النظام" android:textColor="@color/text_secondary"
                    android:textSize="11sp" android:layout_marginStart="6dp"/>
                <Space android:layout_width="10dp" android:layout_height="0dp"/>
                <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:orientation="horizontal" android:background="@drawable/circle_pink"
                    android:padding="8dp" android:gravity="center">
                    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="🌙" android:textSize="14sp"/>
                </LinearLayout>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="الحساب" android:textColor="@color/text_secondary"
                    android:textSize="11sp" android:layout_marginStart="6dp"/>
                <Space android:layout_width="10dp" android:layout_height="0dp"/>
                <LinearLayout android:id="@+id/btnQiblaSmall" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:orientation="horizontal" android:background="@drawable/circle_teal"
                    android:padding="8dp" android:gravity="center">
                    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                        android:text="🧭" android:textSize="14sp"/>
                </LinearLayout>
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="القبلة" android:textColor="@color/text_secondary"
                    android:textSize="11sp" android:layout_marginStart="6dp"/>
            </LinearLayout>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:text="أوقات الصلاة" android:textColor="@color/primary"
                android:textSize="22sp" android:textStyle="bold"/>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:background="@drawable/card_bg"
            android:padding="16dp" android:gravity="center_vertical" android:layout_marginBottom="10dp">
            <TextView android:id="@+id/prayerClock" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:text="--:--:--" android:textColor="@color/primary"
                android:textSize="18sp" android:textStyle="bold"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <TextView android:id="@+id/prayerDayName" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_primary" android:textSize="16sp" android:textStyle="bold"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="end">
                <TextView android:id="@+id/prayerHijriDate" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:textColor="@color/text_primary" android:textSize="13sp"/>
                <TextView android:id="@+id/prayerGregDate" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:textColor="@color/text_secondary" android:textSize="11sp"/>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:background="@drawable/card_bg"
            android:padding="16dp" android:gravity="center_vertical" android:layout_marginBottom="10dp">
            <ImageView android:id="@+id/prayerNextIcon" android:layout_width="44dp" android:layout_height="44dp"
                android:src="@drawable/ic_sun"/>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="end">
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="الصلاة القادمة" android:textColor="@color/text_secondary"
                    android:textSize="12sp" android:gravity="end"/>
                <TextView android:id="@+id/prayerNextName" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="--" android:textColor="@color/text_primary"
                    android:textSize="18sp" android:textStyle="bold"/>
            </LinearLayout>
            <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
            <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:orientation="vertical" android:gravity="end">
                <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="الوقت المتبقي" android:textColor="@color/text_secondary"
                    android:textSize="12sp" android:gravity="end"/>
                <TextView android:id="@+id/prayerCountdown" android:layout_width="wrap_content" android:layout_height="wrap_content"
                    android:text="--:--:--" android:textColor="@color/primary"
                    android:textSize="22sp" android:textStyle="bold"/>
            </LinearLayout>
        </LinearLayout>

        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="10dp">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnCitySearch"
                android:layout_width="wrap_content" android:layout_height="48dp"
                android:text="بحث" android:textColor="#FFFFFF" android:backgroundTint="@color/primary"
                app:cornerRadius="12dp" android:minWidth="80dp"
                android:insetTop="0dp" android:insetBottom="0dp" android:layout_marginEnd="8dp"/>
            <EditText android:id="@+id/cityEdit" android:layout_width="0dp" android:layout_height="48dp"
                android:layout_weight="1" android:hint="اسم المدينة"
                android:textColorHint="@color/text_secondary" android:textColor="@color/text_primary"
                android:background="@drawable/search_bg" android:paddingStart="16dp" android:paddingEnd="16dp"
                android:textSize="14sp" android:singleLine="true" android:inputType="text" android:gravity="end"/>
        </LinearLayout>

        <com.google.android.material.button.MaterialButton android:id="@+id/btnUseLocation"
            android:layout_width="match_parent" android:layout_height="48dp"
            android:text="🧭 موقعي الحالي" android:textColor="@color/primary"
            android:backgroundTint="@android:color/transparent"
            app:strokeColor="@color/primary" app:strokeWidth="1dp" app:cornerRadius="12dp"
            android:insetTop="0dp" android:insetBottom="0dp" android:layout_marginBottom="14dp"/>

        <LinearLayout android:id="@+id/prayerList" android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="vertical"/>

        <ProgressBar android:id="@+id/prayerLoading" android:layout_width="40dp" android:layout_height="40dp"
            android:layout_gravity="center" android:layout_marginTop="20dp" android:indeterminateTint="@color/primary"/>

    </LinearLayout>
</ScrollView>
L7

cat > $PROJECT/app/src/main/res/layout/fragment_qibla.xml << 'L8'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:background="@color/bg" android:padding="24dp">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="🧭 اتجاه القبلة" android:textColor="@color/primary" android:textSize="26sp"
        android:textStyle="bold" android:layout_marginTop="16dp"/>
    <FrameLayout android:layout_width="280dp" android:layout_height="280dp" android:layout_marginTop="32dp"
        android:background="@drawable/circle_white">
        <TextView android:id="@+id/qiblaDirection" android:layout_width="match_parent" android:layout_height="match_parent"
            android:gravity="center" android:textColor="@color/primary" android:textSize="80sp"
            android:textStyle="bold" android:text="🕋"/>
    </FrameLayout>
    <TextView android:id="@+id/qiblaDegrees" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textColor="@color/text_secondary" android:textSize="18sp" android:layout_marginTop="20dp"/>
</LinearLayout>
L8

echo "✅ Quran/Prayer/Qibla layouts written"

cat > $PROJECT/app/src/main/res/layout/fragment_adhkar.xml << 'L9'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:paddingStart="20dp" android:paddingEnd="20dp"
        android:paddingTop="18dp" android:paddingBottom="6dp">
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content"
            android:text="الأذكار والأدعية" android:textColor="@color/primary"
            android:textSize="26sp" android:textStyle="bold" android:gravity="center"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
            android:orientation="vertical" android:gravity="end" android:layout_marginTop="14dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:text="الأذكار" android:textColor="@color/primary"
                android:textSize="18sp" android:textStyle="bold" android:layout_gravity="end"/>
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:text="أذكار السنة اليومية" android:textColor="@color/text_secondary"
                android:textSize="12sp" android:layout_gravity="end" android:layout_marginTop="2dp"/>
        </LinearLayout>
    </LinearLayout>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/adhkarRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent"
        android:paddingStart="12dp" android:paddingEnd="12dp" android:paddingBottom="16dp"
        android:clipToPadding="false"/>
</LinearLayout>
L9

cat > $PROJECT/app/src/main/res/layout/item_adhkar_category.xml << 'L10'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="wrap_content"
    android:orientation="vertical" android:gravity="center" android:padding="18dp"
    android:background="@drawable/card_bg" android:layout_margin="6dp">
    <LinearLayout android:id="@+id/adhkarIconBg" android:layout_width="64dp" android:layout_height="64dp"
        android:background="@drawable/circle_purple" android:gravity="center" android:orientation="vertical">
        <TextView android:id="@+id/adhkarIcon" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textSize="28sp"/>
    </LinearLayout>
    <TextView android:id="@+id/adhkarName" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textColor="@color/text_primary" android:textSize="15sp" android:textStyle="bold"
        android:layout_marginTop="10dp" android:gravity="center"/>
    <TextView android:id="@+id/adhkarProgress" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_marginTop="4dp"/>
</LinearLayout>
L10

cat > $PROJECT/app/src/main/res/layout/fragment_adhkar_detail.xml << 'L11'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="horizontal" android:gravity="center_vertical"
        android:paddingStart="16dp" android:paddingEnd="16dp" android:paddingTop="16dp" android:paddingBottom="10dp">
        <ImageView android:id="@+id/adhkarBackBtn" android:layout_width="40dp" android:layout_height="40dp"
            android:src="@drawable/ic_back" android:padding="8dp" android:background="@drawable/circle_white"/>
        <Space android:layout_width="10dp" android:layout_height="0dp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/adhkarResetBtn"
            android:layout_width="wrap_content" android:layout_height="40dp"
            android:text="↻ إعادة" android:textColor="@color/primary"
            android:backgroundTint="@color/bg_card"
            app:strokeColor="@color/card_stroke" app:strokeWidth="1dp" app:cornerRadius="20dp"
            android:textSize="13sp" android:minWidth="0dp"
            android:insetTop="0dp" android:insetBottom="0dp"/>
        <Space android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/>
        <TextView android:id="@+id/adhkarDetailTitle" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:text="أذكار" android:textColor="@color/text_primary"
            android:textSize="18sp" android:textStyle="bold"/>
        <Space android:layout_width="10dp" android:layout_height="0dp"/>
        <ImageView android:id="@+id/adhkarNextBtn" android:layout_width="40dp" android:layout_height="40dp"
            android:src="@drawable/ic_chevron_left" android:padding="8dp" android:background="@drawable/circle_white"/>
    </LinearLayout>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/adhkarItemsRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent"
        android:paddingStart="16dp" android:paddingEnd="16dp" android:paddingBottom="16dp"
        android:clipToPadding="false"/>
</LinearLayout>
L11

cat > $PROJECT/app/src/main/res/layout/item_dhikr.xml << 'L12'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="wrap_content"
    android:orientation="vertical" android:padding="18dp"
    android:background="@drawable/card_bg" android:layout_marginBottom="10dp">
    <TextView android:id="@+id/dhikrText" android:layout_width="match_parent" android:layout_height="wrap_content"
        android:textColor="@color/text_primary" android:textSize="17sp"
        android:lineSpacingExtra="4dp" android:gravity="end" android:textDirection="rtl"/>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginTop="14dp">
        <TextView android:id="@+id/dhikrSource" android:layout_width="0dp" android:layout_height="wrap_content"
            android:layout_weight="1" android:textColor="@color/text_secondary" android:textSize="12sp"/>
        <TextView android:id="@+id/dhikrCount" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/primary" android:textSize="14sp" android:textStyle="bold"
            android:paddingStart="12dp" android:paddingEnd="12dp" android:paddingTop="6dp" android:paddingBottom="6dp"
            android:background="@drawable/reset_btn_bg"/>
    </LinearLayout>
    <ProgressBar android:id="@+id/dhikrProgress" style="?android:attr/progressBarStyleHorizontal"
        android:layout_width="match_parent" android:layout_height="4dp"
        android:max="100" android:progress="0" android:progressDrawable="@drawable/dhikr_progress"
        android:layout_marginTop="10dp"/>
</LinearLayout>
L12

cat > $PROJECT/app/src/main/res/layout/item_prayer_row.xml << 'L13'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="wrap_content"
    android:orientation="horizontal" android:gravity="center_vertical"
    android:background="@drawable/card_bg" android:padding="16dp" android:layout_marginBottom="8dp">
    <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content"
        android:layout_weight="1" android:orientation="vertical">
        <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:orientation="horizontal" android:gravity="center_vertical">
            <TextView android:id="@+id/prayerName" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_primary" android:textSize="16sp" android:textStyle="bold"/>
            <TextView android:id="@+id/prayerNext" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:text=" التالية " android:textColor="#FFFFFF" android:textSize="11sp"
                android:background="@drawable/filter_active"
                android:paddingStart="8dp" android:paddingEnd="8dp" android:paddingTop="2dp" android:paddingBottom="2dp"
                android:layout_marginStart="8dp" android:visibility="gone"/>
        </LinearLayout>
        <TextView android:id="@+id/prayerTime" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/text_primary" android:textSize="22sp" android:textStyle="bold"
            android:layout_marginTop="2dp"/>
    </LinearLayout>
    <ImageView android:id="@+id/prayerIcon" android:layout_width="44dp" android:layout_height="44dp"/>
</LinearLayout>
L13

cat > $PROJECT/app/src/main/res/layout/fragment_bookmarks.xml << 'L14'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg" android:padding="16dp">
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content"
        android:text="📌 المحفوظات" android:textColor="@color/primary"
        android:textSize="22sp" android:textStyle="bold" android:gravity="center" android:paddingBottom="14dp"/>
    <TextView android:id="@+id/emptyBookmarks" android:layout_width="match_parent" android:layout_height="match_parent"
        android:text="لا توجد صفحات محفوظة" android:textColor="@color/text_secondary"
        android:textSize="16sp" android:gravity="center" android:visibility="gone"/>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/bookmarksRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent"/>
</LinearLayout>
L14

echo "✅ Adhkar/bookmarks layouts written"

# ========== KOTLIN: Splash + Main + Models + QuranData ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/SplashActivity.kt << 'K1'
package tech.meshari.quran

import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.content.Intent
import android.os.Bundle
import android.view.animation.OvershootInterpolator
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
        val logoAlpha = ObjectAnimator.ofFloat(logo, "alpha", 0f, 1f).setDuration(600)
        val logoScale = ObjectAnimator.ofFloat(logo, "scaleX", 0.3f, 1f).setDuration(800)
        val logoScaleY = ObjectAnimator.ofFloat(logo, "scaleY", 0.3f, 1f).setDuration(800)
        logoScale.interpolator = OvershootInterpolator()
        logoScaleY.interpolator = OvershootInterpolator()
        val titleAlpha = ObjectAnimator.ofFloat(title, "alpha", 0f, 1f).setDuration(500)
        val titleY = ObjectAnimator.ofFloat(title, "translationY", 30f, 0f).setDuration(500)
        val subAlpha = ObjectAnimator.ofFloat(subtitle, "alpha", 0f, 1f).setDuration(400)
        AnimatorSet().apply { playTogether(logoAlpha, logoScale, logoScaleY); start() }
        logo.postDelayed({ AnimatorSet().apply { playTogether(titleAlpha, titleY); start() } }, 500)
        logo.postDelayed({ subAlpha.start() }, 800)
        logo.postDelayed({
            startActivity(Intent(this, MainActivity::class.java))
            overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
            finish()
        }, 1800)
    }
}
K1

cat > $PROJECT/app/src/main/java/$PKG_PATH/MainActivity.kt << 'K2'
package tech.meshari.quran

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.google.android.material.bottomnavigation.BottomNavigationView
import tech.meshari.quran.ui.*

class MainActivity : AppCompatActivity() {
    private lateinit var bottomNav: BottomNavigationView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        bottomNav = findViewById(R.id.bottomNav)
        loadFragment(HomeFragment())
        bottomNav.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.nav_home -> loadFragment(HomeFragment())
                R.id.nav_quran -> loadFragment(SurahListFragment())
                R.id.nav_adhkar -> loadFragment(AdhkarFragment())
                R.id.nav_prayer -> loadFragment(PrayerFragment())
                R.id.nav_more -> loadFragment(MoreFragment())
            }
            true
        }
    }

    fun loadFragment(fragment: Fragment) {
        supportFragmentManager.popBackStack(null, androidx.fragment.app.FragmentManager.POP_BACK_STACK_INCLUSIVE)
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, fragment).commit()
    }

    fun pushFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, fragment).addToBackStack(null).commit()
    }

    fun openReader(surahNumber: Int, page: Int) {
        pushFragment(ReaderFragment.newInstance(surahNumber, page))
    }

    fun selectTab(id: Int) { bottomNav.selectedItemId = id }
}
K2

cat > $PROJECT/app/src/main/java/$PKG_PATH/data/Models.kt << 'K3'
package tech.meshari.quran.data

data class Surah(val n: Int, val name: String, val ename: String, val ayas: Int, val type: String, val page: Int)
data class Reciter(val id: String, val name: String, val server: String)
data class PrayerTimes(val fajr: String, val sunrise: String, val dhuhr: String, val asr: String, val maghrib: String, val isha: String)

data class AdhkarCategory(
    val id: String,
    val name: String,
    val emoji: String,
    val colorCircleRes: Int,
    val items: List<Dhikr>
)

data class Dhikr(
    val id: String,
    val text: String,
    val source: String,
    val target: Int
)
K3

echo "✅ Splash + Main + Models written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/data/QuranData.kt << 'K4'
package tech.meshari.quran.data

object QuranData {
    val surahs = listOf(
        Surah(1,"الفاتحة","Al-Fatihah",7,"Meccan",1),Surah(2,"البقرة","Al-Baqarah",286,"Medinan",2),
        Surah(3,"آل عمران","Aal-Imran",200,"Medinan",50),Surah(4,"النساء","An-Nisa",176,"Medinan",77),
        Surah(5,"المائدة","Al-Maidah",120,"Medinan",106),Surah(6,"الأنعام","Al-Anam",165,"Meccan",128),
        Surah(7,"الأعراف","Al-Araf",206,"Meccan",151),Surah(8,"الأنفال","Al-Anfal",75,"Medinan",177),
        Surah(9,"التوبة","At-Tawbah",129,"Medinan",187),Surah(10,"يونس","Yunus",109,"Meccan",208),
        Surah(11,"هود","Hud",123,"Meccan",221),Surah(12,"يوسف","Yusuf",111,"Meccan",235),
        Surah(13,"الرعد","Ar-Rad",43,"Medinan",249),Surah(14,"إبراهيم","Ibrahim",52,"Meccan",255),
        Surah(15,"الحجر","Al-Hijr",99,"Meccan",262),Surah(16,"النحل","An-Nahl",128,"Meccan",267),
        Surah(17,"الإسراء","Al-Isra",111,"Meccan",282),Surah(18,"الكهف","Al-Kahf",110,"Meccan",293),
        Surah(19,"مريم","Maryam",98,"Meccan",305),Surah(20,"طه","Ta-Ha",135,"Meccan",312),
        Surah(21,"الأنبياء","Al-Anbiya",112,"Meccan",322),Surah(22,"الحج","Al-Hajj",78,"Medinan",332),
        Surah(23,"المؤمنون","Al-Muminun",118,"Meccan",342),Surah(24,"النور","An-Nur",64,"Medinan",350),
        Surah(25,"الفرقان","Al-Furqan",77,"Meccan",359),Surah(26,"الشعراء","Ash-Shuara",227,"Meccan",367),
        Surah(27,"النمل","An-Naml",93,"Meccan",377),Surah(28,"القصص","Al-Qasas",88,"Meccan",385),
        Surah(29,"العنكبوت","Al-Ankabut",69,"Meccan",396),Surah(30,"الروم","Ar-Rum",60,"Meccan",404),
        Surah(31,"لقمان","Luqman",34,"Meccan",411),Surah(32,"السجدة","As-Sajdah",30,"Meccan",415),
        Surah(33,"الأحزاب","Al-Ahzab",73,"Medinan",418),Surah(34,"سبأ","Saba",54,"Meccan",428),
        Surah(35,"فاطر","Fatir",45,"Meccan",434),Surah(36,"يس","Ya-Sin",83,"Meccan",440),
        Surah(37,"الصافات","As-Saffat",182,"Meccan",446),Surah(38,"ص","Sad",88,"Meccan",453),
        Surah(39,"الزمر","Az-Zumar",75,"Meccan",458),Surah(40,"غافر","Ghafir",85,"Meccan",467),
        Surah(41,"فصلت","Fussilat",54,"Meccan",477),Surah(42,"الشورى","Ash-Shura",53,"Meccan",483),
        Surah(43,"الزخرف","Az-Zukhruf",89,"Meccan",489),Surah(44,"الدخان","Ad-Dukhan",59,"Meccan",496),
        Surah(45,"الجاثية","Al-Jathiyah",37,"Meccan",499),Surah(46,"الأحقاف","Al-Ahqaf",35,"Meccan",502),
        Surah(47,"محمد","Muhammad",38,"Medinan",507),Surah(48,"الفتح","Al-Fath",29,"Medinan",511),
        Surah(49,"الحجرات","Al-Hujurat",18,"Medinan",515),Surah(50,"ق","Qaf",45,"Meccan",518),
        Surah(51,"الذاريات","Adh-Dhariyat",60,"Meccan",520),Surah(52,"الطور","At-Tur",49,"Meccan",523),
        Surah(53,"النجم","An-Najm",62,"Meccan",526),Surah(54,"القمر","Al-Qamar",55,"Meccan",528),
        Surah(55,"الرحمن","Ar-Rahman",78,"Medinan",531),Surah(56,"الواقعة","Al-Waqiah",96,"Meccan",534),
        Surah(57,"الحديد","Al-Hadid",29,"Medinan",537),Surah(58,"المجادلة","Al-Mujadilah",22,"Medinan",542),
        Surah(59,"الحشر","Al-Hashr",24,"Medinan",545),Surah(60,"الممتحنة","Al-Mumtahanah",13,"Medinan",549),
        Surah(61,"الصف","As-Saff",14,"Medinan",551),Surah(62,"الجمعة","Al-Jumuah",11,"Medinan",553),
        Surah(63,"المنافقون","Al-Munafiqun",11,"Medinan",554),Surah(64,"التغابن","At-Taghabun",18,"Medinan",556),
        Surah(65,"الطلاق","At-Talaq",12,"Medinan",558),Surah(66,"التحريم","At-Tahrim",12,"Medinan",560),
        Surah(67,"الملك","Al-Mulk",30,"Meccan",562),Surah(68,"القلم","Al-Qalam",52,"Meccan",564),
        Surah(69,"الحاقة","Al-Haqqah",52,"Meccan",566),Surah(70,"المعارج","Al-Maarij",44,"Meccan",568),
        Surah(71,"نوح","Nuh",28,"Meccan",570),Surah(72,"الجن","Al-Jinn",28,"Meccan",572),
        Surah(73,"المزمل","Al-Muzzammil",20,"Meccan",574),Surah(74,"المدثر","Al-Muddaththir",56,"Meccan",575),
        Surah(75,"القيامة","Al-Qiyamah",40,"Meccan",577),Surah(76,"الإنسان","Al-Insan",31,"Medinan",578),
        Surah(77,"المرسلات","Al-Mursalat",50,"Meccan",580),Surah(78,"النبأ","An-Naba",40,"Meccan",582),
        Surah(79,"النازعات","An-Naziat",46,"Meccan",583),Surah(80,"عبس","Abasa",42,"Meccan",585),
        Surah(81,"التكوير","At-Takwir",29,"Meccan",586),Surah(82,"الإنفطار","Al-Infitar",19,"Meccan",587),
        Surah(83,"المطففين","Al-Mutaffifin",36,"Meccan",587),Surah(84,"الإنشقاق","Al-Inshiqaq",25,"Meccan",589),
        Surah(85,"البروج","Al-Buruj",22,"Meccan",590),Surah(86,"الطارق","At-Tariq",17,"Meccan",591),
        Surah(87,"الأعلى","Al-Ala",19,"Meccan",591),Surah(88,"الغاشية","Al-Ghashiyah",26,"Meccan",592),
        Surah(89,"الفجر","Al-Fajr",30,"Meccan",593),Surah(90,"البلد","Al-Balad",20,"Meccan",594),
        Surah(91,"الشمس","Ash-Shams",15,"Meccan",595),Surah(92,"الليل","Al-Lail",21,"Meccan",595),
        Surah(93,"الضحى","Ad-Duha",11,"Meccan",596),Surah(94,"الشرح","Ash-Sharh",8,"Meccan",596),
        Surah(95,"التين","At-Tin",8,"Meccan",597),Surah(96,"العلق","Al-Alaq",19,"Meccan",597),
        Surah(97,"القدر","Al-Qadr",5,"Meccan",598),Surah(98,"البينة","Al-Bayyinah",8,"Medinan",598),
        Surah(99,"الزلزلة","Az-Zalzalah",8,"Medinan",599),Surah(100,"العاديات","Al-Adiyat",11,"Meccan",599),
        Surah(101,"القارعة","Al-Qariah",11,"Meccan",600),Surah(102,"التكاثر","At-Takathur",8,"Meccan",600),
        Surah(103,"العصر","Al-Asr",3,"Meccan",601),Surah(104,"الهمزة","Al-Humazah",9,"Meccan",601),
        Surah(105,"الفيل","Al-Fil",5,"Meccan",601),Surah(106,"قريش","Quraish",4,"Meccan",602),
        Surah(107,"الماعون","Al-Maun",7,"Meccan",602),Surah(108,"الكوثر","Al-Kawthar",3,"Meccan",602),
        Surah(109,"الكافرون","Al-Kafirun",6,"Meccan",603),Surah(110,"النصر","An-Nasr",3,"Medinan",603),
        Surah(111,"المسد","Al-Masad",5,"Meccan",603),Surah(112,"الإخلاص","Al-Ikhlas",4,"Meccan",604),
        Surah(113,"الفلق","Al-Falaq",5,"Meccan",604),Surah(114,"الناس","An-Nas",6,"Meccan",604)
    )
    val reciters = listOf(
        Reciter("102","ماهر المعيقلي","https://server12.mp3quran.net/maher/"),
        Reciter("110","مشاري العفاسي","https://server8.mp3quran.net/afs/"),
        Reciter("120","إدريس أبكر","https://server6.mp3quran.net/abkr/"),
        Reciter("106","محمد أيوب","https://server8.mp3quran.net/ayyub/"),
        Reciter("112","محمد جبريل","https://server8.mp3quran.net/jbrl/"),
        Reciter("100","محمود خليل الحصري","https://server13.mp3quran.net/husr/"),
        Reciter("134","محمد اللحيدان","https://server8.mp3quran.net/lhdan/"),
        Reciter("135","إبراهيم الأخضر","https://server6.mp3quran.net/akdr/"),
        Reciter("136","محمود علي البنا","https://server8.mp3quran.net/bna/"),
        Reciter("109","محمد المحيسني","https://server11.mp3quran.net/mhsny/"),
        Reciter("140","ياسر الدوسري","https://server11.mp3quran.net/yasser/"),
        Reciter("114","أحمد العجمي","https://server10.mp3quran.net/ajm/"),
        Reciter("108","عبدالرحمن السديس","https://server11.mp3quran.net/sds/"),
        Reciter("113","سعود الشريم","https://server7.mp3quran.net/shuraim/"),
        Reciter("105","محمد صديق المنشاوي","https://server10.mp3quran.net/minsh/"),
        Reciter("101","عبدالباسط عبدالصمد","https://server7.mp3quran.net/basit/")
    )
    fun getPageImageUrl(page: Int): String {
        return "https://surahquran.com/img/pages-quran/page" + page.toString().padStart(3, '0') + ".png"
    }
    fun getAudioUrl(reciter: Reciter, surahNumber: Int): String {
        return reciter.server + surahNumber.toString().padStart(3, '0') + ".mp3"
    }
    fun getSurahByPage(page: Int): Surah {
        return surahs.lastOrNull { it.page <= page } ?: surahs[0]
    }
}
K4

echo "✅ QuranData written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/data/AdhkarData.kt << 'K5'
package tech.meshari.quran.data

import tech.meshari.quran.R

object AdhkarData {

    private fun dh(id: String, text: String, source: String, target: Int) = Dhikr(id, text, source, target)

    val morning = listOf(
        dh("m1","أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ، اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ... (آية الكرسي)","البخاري",1),
        dh("m2","بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ، قُلْ هُوَ اللَّهُ أَحَدٌ... (الإخلاص والمعوذتين)","أبو داود والترمذي",3),
        dh("m3","أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ","مسلم",1),
        dh("m4","اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ","الترمذي",1),
        dh("m5","اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ (سيد الاستغفار)","البخاري",1),
        dh("m6","اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ","أبو داود",4),
        dh("m7","اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ","أبو داود",1),
        dh("m8","اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ","أبو داود",3),
        dh("m9","اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ","أبو داود",3),
        dh("m10","حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ","أبو داود",7),
        dh("m11","بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ","أبو داود والترمذي",3),
        dh("m12","رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا","أبو داود والترمذي",3),
        dh("m13","يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ","النسائي والحاكم",1),
        dh("m14","سُبْحَانَ اللَّهِ وَبِحَمْدِهِ","مسلم",100)
    )

    val evening = listOf(
        dh("e1","أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ، اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ... (آية الكرسي)","البخاري",1),
        dh("e2","بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ، قُلْ هُوَ اللَّهُ أَحَدٌ... (الإخلاص والمعوذتين)","أبو داود والترمذي",3),
        dh("e3","أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ","مسلم",1),
        dh("e4","اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ","الترمذي",1),
        dh("e5","اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ... (سيد الاستغفار)","البخاري",1),
        dh("e6","اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ","أبو داود",4),
        dh("e7","اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي","أبو داود",3),
        dh("e8","أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ","مسلم",3),
        dh("e9","بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ","أبو داود والترمذي",3),
        dh("e10","سُبْحَانَ اللَّهِ وَبِحَمْدِهِ","مسلم",100)
    )

    val sleep = listOf(
        dh("s1","قُلْ هُوَ اللَّهُ أَحَدٌ، قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، قُلْ أَعُوذُ بِرَبِّ النَّاسِ","البخاري",3),
        dh("s2","آيَةَ الْكُرْسِيِّ","البخاري",1),
        dh("s3","بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا","البخاري ومسلم",1),
        dh("s4","اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا","البخاري",1),
        dh("s5","اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ","أبو داود",3),
        dh("s6","سُبْحَانَ اللَّهِ 33، الْحَمْدُ لِلَّهِ 33، اللَّهُ أَكْبَرُ 34","البخاري",1),
        dh("s7","اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ","البخاري ومسلم",1)
    )

    val afterPrayer = listOf(
        dh("a1","أَسْتَغْفِرُ اللَّهَ","مسلم",3),
        dh("a2","اللَّهُمَّ أَنْتَ السَّلَامُ، وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ","مسلم",1),
        dh("a3","لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ","البخاري ومسلم",1),
        dh("a4","سُبْحَانَ اللَّهِ","مسلم",33),
        dh("a5","الْحَمْدُ لِلَّهِ","مسلم",33),
        dh("a6","اللَّهُ أَكْبَرُ (33 مرة) ثم: لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ","مسلم",34),
        dh("a7","آيَةُ الْكُرْسِيِّ","النسائي",1),
        dh("a8","قُلْ هُوَ اللَّهُ أَحَدٌ، قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، قُلْ أَعُوذُ بِرَبِّ النَّاسِ","أبو داود والنسائي",1),
        dh("a9","اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ، وَشُكْرِكَ، وَحُسْنِ عِبَادَتِكَ","أبو داود والنسائي",1),
        dh("a10","اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْجُبْنِ، وَأَعُوذُ بِكَ مِنْ أَنْ أُرَدَّ إِلَى أَرْذَلِ الْعُمُرِ","البخاري",1)
    )

    val mosque = listOf(
        dh("ms1","عند دخول المسجد: بِسْمِ اللَّهِ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِ اللَّهِ، اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ","مسلم وأبو داود",1),
        dh("ms2","عند الخروج من المسجد: بِسْمِ اللَّهِ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِ اللَّهِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ","مسلم وأبو داود",1),
        dh("ms3","إجابة المؤذن: يُقَالُ مِثْلَ مَا يَقُولُ الْمُؤَذِّنُ، إِلَّا فِي الْحَيْعَلَتَيْنِ فَيُقَالُ: لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ","البخاري ومسلم",1),
        dh("ms4","الدعاء بعد الأذان: اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ، وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ","البخاري",1)
    )

    val waking = listOf(
        dh("w1","الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ","البخاري ومسلم",1),
        dh("w2","لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ","البخاري",1),
        dh("w3","اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ","الترمذي",1),
        dh("w4","قراءة العشر الأواخر من سورة آل عمران (إِنَّ فِي خَلْقِ السَّمَاوَاتِ وَالْأَرْضِ...)","البخاري ومسلم",1)
    )

    val wudu = listOf(
        dh("wu1","قبل الوضوء: بِسْمِ اللَّهِ","أبو داود وابن ماجه",1),
        dh("wu2","بعد الوضوء: أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ","مسلم",1),
        dh("wu3","اللَّهُمَّ اجْعَلْنِي مِنَ التَّوَّابِينَ، وَاجْعَلْنِي مِنَ الْمُتَطَهِّرِينَ","الترمذي",1),
        dh("wu4","سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَسْتَغْفِرُكَ وَأَتُوبُ إِلَيْكَ","النسائي",1)
    )

    val travel = listOf(
        dh("t1","اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ","مسلم",1),
        dh("t2","اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى، اللَّهُمَّ هَوِّنْ عَلَيْنَا سَفَرَنَا هَذَا","مسلم",1),
        dh("t3","اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ وَعْثَاءِ السَّفَرِ، وَكَآبَةِ الْمَنْظَرِ، وَسُوءِ الْمُنْقَلَبِ فِي الْمَالِ وَالْأَهْلِ","مسلم",1),
        dh("t4","اللَّهُمَّ أَنْتَ الصَّاحِبُ فِي السَّفَرِ، وَالْخَلِيفَةُ فِي الْأَهْلِ","مسلم",1)
    )

    val home = listOf(
        dh("h1","عند دخول البيت: بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى رَبِّنَا تَوَكَّلْنَا","أبو داود",1),
        dh("h2","عند الخروج من البيت: بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ","أبو داود والترمذي",1)
    )

    val adhan = listOf(
        dh("ad1","ترديد ما يقوله المؤذن، إلا في الحيعلتين: لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ","البخاري ومسلم",1),
        dh("ad2","الصلاة على النبي ﷺ بعد الأذان","مسلم",1),
        dh("ad3","اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ، وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَامًا مَحْمُودًا الَّذِي وَعَدْتَهُ","البخاري",1),
        dh("ad4","الدعاء بين الأذان والإقامة","أبو داود والترمذي",1)
    )

    val categories: List<AdhkarCategory> = listOf(
        AdhkarCategory("morning","أذكار الصباح","🌅", R.drawable.circle_orange, morning),
        AdhkarCategory("evening","أذكار المساء","🌙", R.drawable.circle_purple, evening),
        AdhkarCategory("after_prayer","أذكار بعد الصلاة","✨", R.drawable.circle_green, afterPrayer),
        AdhkarCategory("sleep","أذكار النوم","🛏", R.drawable.circle_blue, sleep),
        AdhkarCategory("waking","أذكار الاستيقاظ","⏰", R.drawable.circle_yellow, waking),
        AdhkarCategory("mosque","أذكار المسجد","🕌", R.drawable.circle_pink, mosque),
        AdhkarCategory("wudu","أذكار الوضوء","💧", R.drawable.circle_teal, wudu),
        AdhkarCategory("travel","أذكار السفر","✈️", R.drawable.circle_blue, travel),
        AdhkarCategory("home","أذكار المنزل","🏠", R.drawable.circle_brown, home),
        AdhkarCategory("adhan","أذكار الأذان","📣", R.drawable.circle_mint, adhan)
    )

    fun byId(id: String): AdhkarCategory? = categories.firstOrNull { it.id == id }
}
K5

echo "✅ AdhkarData written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/util/MoonPhase.kt << 'K6'
package tech.meshari.quran.util

import java.util.Calendar
import kotlin.math.floor

object MoonPhase {
    data class Phase(val nameAr: String, val nameEn: String, val illumination: Int)

    fun current(): Phase {
        val c = Calendar.getInstance()
        val y = c.get(Calendar.YEAR)
        val m = c.get(Calendar.MONTH) + 1
        val d = c.get(Calendar.DAY_OF_MONTH)
        val r = phaseAge(y, m, d)
        val age = r
        val illum = ((1 - Math.cos(2 * Math.PI * age / 29.53)) / 2.0 * 100).toInt().coerceIn(0, 100)
        val name = when {
            age < 1.84566 -> "محاق" to "New Moon"
            age < 5.53699 -> "هلال متزايد" to "Waxing Crescent"
            age < 9.22831 -> "تربيع أول" to "First Quarter"
            age < 12.91963 -> "أحدب متزايد" to "Waxing Gibbous"
            age < 16.61096 -> "بدر" to "Full Moon"
            age < 20.30228 -> "أحدب متناقص" to "Waning Gibbous"
            age < 23.99361 -> "تربيع أخير" to "Last Quarter"
            age < 27.68493 -> "هلال متناقص" to "Waning Crescent"
            else -> "محاق" to "New Moon"
        }
        return Phase(name.first, name.second, illum)
    }

    private fun phaseAge(y: Int, m: Int, d: Int): Double {
        var yy = y
        var mm = m
        if (mm < 3) { yy -= 1; mm += 12 }
        val a = floor(yy / 100.0)
        val b = 2 - a + floor(a / 4.0)
        val jd = floor(365.25 * (yy + 4716)) + floor(30.6001 * (mm + 1)) + d + b - 1524.5
        val daysSinceNew = jd - 2451549.5
        val cycles = daysSinceNew / 29.53058867
        val age = (cycles - floor(cycles)) * 29.53058867
        return age
    }

    fun hijriDay(): Int {
        return ((System.currentTimeMillis() / 86400000.0 - 11324.0) % 29.53).toInt().coerceIn(1, 30) + 1
    }
}
K6

cat > $PROJECT/app/src/main/java/$PKG_PATH/util/Prefs.kt << 'K7'
package tech.meshari.quran.util

import android.content.Context
import android.content.SharedPreferences

object Prefs {
    fun get(ctx: Context): SharedPreferences = ctx.getSharedPreferences("quran_prefs", Context.MODE_PRIVATE)

    fun lastReadPage(ctx: Context): Int = get(ctx).getInt("last_read_page", 0)
    fun setLastReadPage(ctx: Context, page: Int) { get(ctx).edit().putInt("last_read_page", page).apply() }

    fun dhikrCount(ctx: Context, key: String): Int = get(ctx).getInt("dhikr_" + key, 0)
    fun setDhikrCount(ctx: Context, key: String, n: Int) { get(ctx).edit().putInt("dhikr_" + key, n).apply() }
    fun resetCategory(ctx: Context, categoryId: String, ids: List<String>) {
        val e = get(ctx).edit()
        ids.forEach { e.remove("dhikr_" + categoryId + "_" + it) }
        e.apply()
    }

    fun pagesRead(ctx: Context): Int = get(ctx).getInt("pages_read_total", 0)
    fun pagesToday(ctx: Context): Int {
        val today = todayKey()
        val saved = get(ctx).getString("pages_today_date", "") ?: ""
        return if (saved == today) get(ctx).getInt("pages_today", 0) else 0
    }
    fun pagesWeek(ctx: Context): Int = get(ctx).getInt("pages_week_" + weekKey(), 0)
    fun streakDays(ctx: Context): Int = get(ctx).getInt("streak_days", 0)

    fun recordPageRead(ctx: Context) {
        val p = get(ctx)
        val today = todayKey()
        val savedDate = p.getString("pages_today_date", "") ?: ""
        val edit = p.edit()
        if (savedDate != today) {
            edit.putString("pages_today_date", today).putInt("pages_today", 1)
            val lastDay = p.getString("last_read_day", "") ?: ""
            val streak = p.getInt("streak_days", 0)
            val newStreak = if (lastDay == yesterdayKey()) streak + 1 else 1
            edit.putInt("streak_days", newStreak).putString("last_read_day", today)
        } else {
            edit.putInt("pages_today", p.getInt("pages_today", 0) + 1)
        }
        val wk = "pages_week_" + weekKey()
        edit.putInt(wk, p.getInt(wk, 0) + 1)
        edit.putInt("pages_read_total", p.getInt("pages_read_total", 0) + 1)
        edit.apply()
    }

    private fun todayKey(): String {
        val c = java.util.Calendar.getInstance()
        return "" + c.get(java.util.Calendar.YEAR) + "-" + c.get(java.util.Calendar.DAY_OF_YEAR)
    }
    private fun yesterdayKey(): String {
        val c = java.util.Calendar.getInstance(); c.add(java.util.Calendar.DAY_OF_YEAR, -1)
        return "" + c.get(java.util.Calendar.YEAR) + "-" + c.get(java.util.Calendar.DAY_OF_YEAR)
    }
    private fun weekKey(): String {
        val c = java.util.Calendar.getInstance()
        return "" + c.get(java.util.Calendar.YEAR) + "-" + c.get(java.util.Calendar.WEEK_OF_YEAR)
    }
}
K7

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/HomeFragment.kt << 'K8'
package tech.meshari.quran.ui

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.google.gson.JsonParser
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import tech.meshari.quran.data.QuranData
import tech.meshari.quran.util.MoonPhase
import tech.meshari.quran.util.Prefs
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class HomeFragment : Fragment() {
    private var prayerTimings: Map<String, String> = emptyMap()
    private val handler = Handler(Looper.getMainLooper())
    private var countdownRunnable: Runnable? = null
    private var rootView: View? = null

    private val prayerOrderAr = listOf("الفجر","الشروق","الظهر","العصر","المغرب","العشاء")
    private val prayerKeys = listOf("Fajr","Sunrise","Dhuhr","Asr","Maghrib","Isha")

    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val v = inflater.inflate(R.layout.fragment_home, c, false)
        rootView = v
        bindGreeting(v)
        bindMoon(v)
        bindStats(v)
        bindLastRead(v)
        v.findViewById<LinearLayout>(R.id.homeQiblaCard).setOnClickListener {
            (activity as? MainActivity)?.pushFragment(QiblaFragment())
        }
        v.findViewById<View>(R.id.homeLastReadRow).setOnClickListener {
            val page = Prefs.lastReadPage(requireContext())
            if (page > 0) (activity as? MainActivity)?.openReader(QuranData.getSurahByPage(page).n, page)
            else (activity as? MainActivity)?.selectTab(R.id.nav_quran)
        }
        fetchPrayer()
        return v
    }

    override fun onResume() {
        super.onResume()
        rootView?.let { bindStats(it); bindLastRead(it) }
        startCountdown()
    }

    override fun onPause() { super.onPause(); stopCountdown() }

    private fun bindGreeting(v: View) {
        val hour = java.util.Calendar.getInstance().get(java.util.Calendar.HOUR_OF_DAY)
        val greeting = when {
            hour in 4..10 -> "صباح الخير ☀️"
            hour in 11..15 -> "السلام عليكم 🌼"
            hour in 16..18 -> "مساء النور ✨"
            else -> "تصبح على خير 🌙"
        }
        v.findViewById<TextView>(R.id.homeGreeting).text = greeting
        v.findViewById<TextView>(R.id.homeHijri).text = "📅 جاري التحميل..."
    }

    private fun bindMoon(v: View) {
        val p = MoonPhase.current()
        v.findViewById<TextView>(R.id.homeMoonNameAr).text = p.nameAr
        v.findViewById<TextView>(R.id.homeMoonNameEn).text = p.nameEn
        v.findViewById<TextView>(R.id.homeMoonIllum).text = p.illumination.toString() + "%"
        v.findViewById<ProgressBar>(R.id.homeMoonProgress).progress = p.illumination
    }

    private fun bindStats(v: View) {
        val ctx = requireContext()
        v.findViewById<TextView>(R.id.statTotal).text = Prefs.pagesRead(ctx).toString()
        v.findViewById<TextView>(R.id.statStreak).text = Prefs.streakDays(ctx).toString()
        v.findViewById<TextView>(R.id.statWeek).text = Prefs.pagesWeek(ctx).toString()
        v.findViewById<TextView>(R.id.statToday).text = Prefs.pagesToday(ctx).toString()
    }

    private fun bindLastRead(v: View) {
        val page = Prefs.lastReadPage(requireContext())
        val tv = v.findViewById<TextView>(R.id.homeLastReadText)
        if (page > 0) {
            val s = QuranData.getSurahByPage(page)
            tv.text = "صفحة " + page + " — سورة " + s.name
        } else {
            tv.text = "لم تبدأ القراءة بعد — افتح أي سورة لتبدأ"
        }
    }

    private fun fetchPrayer() {
        Thread {
            try {
                val url = java.net.URL("https://api.aladhan.com/v1/timings?latitude=24.7136&longitude=46.6753&method=4")
                val json = url.openConnection().getInputStream().bufferedReader().readText()
                val data = JsonParser.parseString(json).asJsonObject.getAsJsonObject("data")
                val timings = data.getAsJsonObject("timings")
                val hijri = data.getAsJsonObject("date").getAsJsonObject("hijri")
                val map = mutableMapOf<String, String>()
                prayerKeys.forEach { map[it] = timings.get(it).asString }
                val hijriText = hijri.get("day").asString + " " + hijri.getAsJsonObject("month").get("ar").asString + " " + hijri.get("year").asString + " هـ"
                activity?.runOnUiThread {
                    prayerTimings = map
                    rootView?.findViewById<TextView>(R.id.homeHijri)?.text = "📅 " + hijriText
                    startCountdown()
                }
            } catch (e: Exception) {
                activity?.runOnUiThread {
                    rootView?.findViewById<TextView>(R.id.homeHijri)?.text = "📅 ..."
                }
            }
        }.start()
    }

    private fun startCountdown() {
        stopCountdown()
        if (prayerTimings.isEmpty()) return
        val r = object : Runnable {
            override fun run() {
                updateCountdown()
                handler.postDelayed(this, 1000)
            }
        }
        countdownRunnable = r
        handler.post(r)
    }

    private fun stopCountdown() { countdownRunnable?.let { handler.removeCallbacks(it) }; countdownRunnable = null }

    private fun updateCountdown() {
        val v = rootView ?: return
        val cal = java.util.Calendar.getInstance()
        val nowMin = cal.get(java.util.Calendar.HOUR_OF_DAY) * 60 + cal.get(java.util.Calendar.MINUTE)
        val nowSec = cal.get(java.util.Calendar.SECOND)
        var nextIdx = -1
        var nextMin = Int.MAX_VALUE
        for (i in prayerKeys.indices) {
            val t = prayerTimings[prayerKeys[i]] ?: continue
            val parts = t.split(":")
            val tm = (parts[0].toIntOrNull() ?: 0) * 60 + (parts[1].split(" ")[0].toIntOrNull() ?: 0)
            if (tm > nowMin) {
                if (tm - nowMin < nextMin - nowMin || nextIdx == -1) { nextIdx = i; nextMin = tm }
            }
        }
        if (nextIdx == -1) { nextIdx = 0; nextMin = (prayerTimings[prayerKeys[0]]?.split(":")?.get(0)?.toIntOrNull() ?: 0) * 60 + 24*60 }
        val remainSec = (nextMin - nowMin) * 60 - nowSec
        val rs = if (remainSec < 0) remainSec + 24*3600 else remainSec
        val hh = rs / 3600
        val mm = (rs % 3600) / 60
        v.findViewById<TextView>(R.id.homePrayerCountdown).text = String.format(Locale.US, "%02d:%02d", hh, mm)
        v.findViewById<TextView>(R.id.homeNextPrayerName).text = prayerOrderAr[nextIdx]
        val raw = prayerTimings[prayerKeys[nextIdx]] ?: "--:--"
        v.findViewById<TextView>(R.id.homeNextPrayerTime).text = formatTime12(raw)
    }

    private fun formatTime12(s: String): String {
        return try {
            val parts = s.split(" ")[0].split(":")
            val h24 = parts[0].toInt(); val m = parts[1].toInt()
            val ampm = if (h24 < 12) "ص" else "م"
            val h12 = ((h24 + 11) % 12) + 1
            String.format(Locale.US, "%d:%02d %s", h12, m, ampm)
        } catch (e: Exception) { s }
    }
}
K8

echo "✅ HomeFragment + utils written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/AdhkarFragment.kt << 'K9'
package tech.meshari.quran.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import tech.meshari.quran.data.AdhkarCategory
import tech.meshari.quran.data.AdhkarData
import tech.meshari.quran.util.Prefs

class AdhkarFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val v = inflater.inflate(R.layout.fragment_adhkar, c, false)
        val r = v.findViewById<RecyclerView>(R.id.adhkarRecycler)
        r.layoutManager = GridLayoutManager(requireContext(), 2)
        r.adapter = CatAdapter(AdhkarData.categories) { cat ->
            (activity as? MainActivity)?.pushFragment(AdhkarDetailFragment.newInstance(cat.id))
        }
        return v
    }

    inner class CatAdapter(private val items: List<AdhkarCategory>, val onClick: (AdhkarCategory) -> Unit) :
        RecyclerView.Adapter<CatAdapter.VH>() {
        inner class VH(v: View) : RecyclerView.ViewHolder(v) {
            val iconBg: LinearLayout = v.findViewById(R.id.adhkarIconBg)
            val icon: TextView = v.findViewById(R.id.adhkarIcon)
            val name: TextView = v.findViewById(R.id.adhkarName)
            val progress: TextView = v.findViewById(R.id.adhkarProgress)
        }
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH {
            val view = LayoutInflater.from(parent.context).inflate(R.layout.item_adhkar_category, parent, false)
            val lp = view.layoutParams ?: ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
            view.layoutParams = lp
            return VH(view)
        }
        override fun getItemCount() = items.size
        override fun onBindViewHolder(h: VH, position: Int) {
            val it = items[position]
            h.iconBg.setBackgroundResource(it.colorCircleRes)
            h.icon.text = it.emoji
            h.name.text = it.name
            val done = it.items.count { dh -> Prefs.dhikrCount(requireContext(), it.id + "_" + dh.id) >= dh.target }
            h.progress.text = done.toString() + "/" + it.items.size
            h.itemView.setOnClickListener { onClick(it) }
        }
    }
}
K9

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/AdhkarDetailFragment.kt << 'K10'
package tech.meshari.quran.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.button.MaterialButton
import tech.meshari.quran.R
import tech.meshari.quran.data.AdhkarCategory
import tech.meshari.quran.data.AdhkarData
import tech.meshari.quran.data.Dhikr
import tech.meshari.quran.util.Prefs

class AdhkarDetailFragment : Fragment() {
    private lateinit var category: AdhkarCategory
    private lateinit var adapter: ItemsAdapter

    companion object {
        fun newInstance(catId: String) = AdhkarDetailFragment().apply {
            arguments = Bundle().apply { putString("cat", catId) }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val v = inflater.inflate(R.layout.fragment_adhkar_detail, c, false)
        val catId = arguments?.getString("cat") ?: "morning"
        category = AdhkarData.byId(catId) ?: AdhkarData.categories[0]
        v.findViewById<TextView>(R.id.adhkarDetailTitle).text = category.name
        v.findViewById<ImageView>(R.id.adhkarBackBtn).setOnClickListener { parentFragmentManager.popBackStack() }
        v.findViewById<ImageView>(R.id.adhkarNextBtn).setOnClickListener {
            val idx = AdhkarData.categories.indexOfFirst { it.id == category.id }
            if (idx >= 0) {
                val next = AdhkarData.categories[(idx + 1) % AdhkarData.categories.size]
                parentFragmentManager.popBackStack()
                (activity as? tech.meshari.quran.MainActivity)?.pushFragment(newInstance(next.id))
            }
        }
        v.findViewById<MaterialButton>(R.id.adhkarResetBtn).setOnClickListener {
            Prefs.resetCategory(requireContext(), category.id, category.items.map { it.id })
            adapter.notifyDataSetChanged()
        }
        val rv = v.findViewById<RecyclerView>(R.id.adhkarItemsRecycler)
        rv.layoutManager = LinearLayoutManager(requireContext())
        adapter = ItemsAdapter(category.items)
        rv.adapter = adapter
        return v
    }

    inner class ItemsAdapter(private val items: List<Dhikr>) : RecyclerView.Adapter<ItemsAdapter.VH>() {
        inner class VH(v: View) : RecyclerView.ViewHolder(v) {
            val text: TextView = v.findViewById(R.id.dhikrText)
            val source: TextView = v.findViewById(R.id.dhikrSource)
            val count: TextView = v.findViewById(R.id.dhikrCount)
            val prog: ProgressBar = v.findViewById(R.id.dhikrProgress)
        }
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
            VH(LayoutInflater.from(parent.context).inflate(R.layout.item_dhikr, parent, false))
        override fun getItemCount() = items.size
        override fun onBindViewHolder(h: VH, position: Int) {
            val d = items[position]
            val key = category.id + "_" + d.id
            h.text.text = d.text
            h.source.text = d.source
            val n = Prefs.dhikrCount(requireContext(), key)
            h.count.text = n.toString() + "/" + d.target
            h.prog.max = d.target
            h.prog.progress = n.coerceAtMost(d.target)
            h.itemView.setOnClickListener {
                val cur = Prefs.dhikrCount(requireContext(), key)
                if (cur < d.target) {
                    val next = cur + 1
                    Prefs.setDhikrCount(requireContext(), key, next)
                    h.count.text = next.toString() + "/" + d.target
                    h.prog.progress = next
                }
            }
        }
    }
}
K10

echo "✅ Adhkar fragments written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/SurahListFragment.kt << 'K11'
package tech.meshari.quran.ui

import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.button.MaterialButton
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import tech.meshari.quran.data.QuranData

class SurahListFragment : Fragment() {
    private var currentFilter = "all"
    private lateinit var adapter: SurahAdapter
    private var btnAll: MaterialButton? = null
    private var btnMeccan: MaterialButton? = null
    private var btnMedinan: MaterialButton? = null

    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_surah_list, c, false)
        val recycler = view.findViewById<RecyclerView>(R.id.surahRecycler)
        btnAll = view.findViewById(R.id.btnAll)
        btnMeccan = view.findViewById(R.id.btnMeccan)
        btnMedinan = view.findViewById(R.id.btnMedinan)
        adapter = SurahAdapter { surah -> (activity as? MainActivity)?.openReader(surah.n, surah.page) }
        recycler.layoutManager = LinearLayoutManager(requireContext())
        recycler.adapter = adapter
        updateList()
        btnAll?.setOnClickListener { currentFilter = "all"; setActive(btnAll!!); updateList() }
        btnMeccan?.setOnClickListener { currentFilter = "Meccan"; setActive(btnMeccan!!); updateList() }
        btnMedinan?.setOnClickListener { currentFilter = "Medinan"; setActive(btnMedinan!!); updateList() }
        return view
    }

    private fun setActive(active: MaterialButton) {
        val all = listOf(btnAll, btnMeccan, btnMedinan)
        all.forEach {
            val b = it ?: return@forEach
            if (b === active) {
                b.setBackgroundColor(resources.getColor(R.color.primary, null))
                b.setTextColor(Color.WHITE)
            } else {
                b.setBackgroundColor(Color.TRANSPARENT)
                b.setTextColor(resources.getColor(R.color.text_primary, null))
            }
        }
    }

    private fun updateList() {
        var list = QuranData.surahs
        if (currentFilter != "all") list = list.filter { it.type == currentFilter }
        adapter.submitList(list)
    }
}
K11

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/SurahAdapter.kt << 'K12'
package tech.meshari.quran.ui

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import tech.meshari.quran.R
import tech.meshari.quran.data.Surah

class SurahAdapter(private val onClick: (Surah) -> Unit) : ListAdapter<Surah, SurahAdapter.VH>(object : DiffUtil.ItemCallback<Surah>() {
    override fun areItemsTheSame(a: Surah, b: Surah) = a.n == b.n
    override fun areContentsTheSame(a: Surah, b: Surah) = a == b
}) {
    inner class VH(v: View) : RecyclerView.ViewHolder(v) {
        val number: TextView = v.findViewById(R.id.surahNumber)
        val nameAr: TextView = v.findViewById(R.id.surahNameAr)
        val nameEn: TextView = v.findViewById(R.id.surahNameEn)
        val type: TextView = v.findViewById(R.id.surahType)
        val ayahs: TextView = v.findViewById(R.id.surahAyahs)
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = VH(LayoutInflater.from(parent.context).inflate(R.layout.item_surah, parent, false))
    override fun onBindViewHolder(holder: VH, position: Int) {
        val s = getItem(position)
        val ctx = holder.itemView.context
        holder.number.text = s.n.toString()
        holder.nameAr.text = s.name
        holder.nameEn.text = s.ename
        holder.ayahs.text = s.ayas.toString() + " آية"
        if (s.type == "Meccan") {
            holder.type.text = "مكية"
            holder.type.setBackgroundResource(R.drawable.badge_meccan)
            holder.type.setTextColor(ctx.resources.getColor(R.color.meccan, null))
        } else {
            holder.type.text = "مدنية"
            holder.type.setBackgroundResource(R.drawable.badge_medinan)
            holder.type.setTextColor(ctx.resources.getColor(R.color.medinan, null))
        }
        holder.itemView.setOnClickListener { onClick(s) }
    }
}
K12

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/ReaderFragment.kt << 'K13'
package tech.meshari.quran.ui

import android.media.MediaPlayer
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import com.bumptech.glide.Glide
import tech.meshari.quran.R
import tech.meshari.quran.data.QuranData
import tech.meshari.quran.util.Prefs

class ReaderFragment : Fragment() {
    private var currentPage = 1
    private var mediaPlayer: MediaPlayer? = null
    private var isPlaying = false
    private var selectedReciterIndex = 0

    companion object {
        fun newInstance(surahNum: Int, page: Int) = ReaderFragment().apply {
            arguments = Bundle().apply { putInt("surah", surahNum); putInt("page", page) }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val v = inflater.inflate(R.layout.fragment_reader, c, false)
        currentPage = arguments?.getInt("page", 1) ?: 1
        val pageImage = v.findViewById<ImageView>(R.id.quranPageImage)
        val pageLoading = v.findViewById<ProgressBar>(R.id.pageLoading)
        val title = v.findViewById<TextView>(R.id.surahTitle)
        val pageInfo = v.findViewById<TextView>(R.id.pageInfo)
        val btnPrev = v.findViewById<ImageView>(R.id.btnPrev)
        val btnNext = v.findViewById<ImageView>(R.id.btnNext)
        val btnPlay = v.findViewById<ImageView>(R.id.btnPlay)
        val btnBack = v.findViewById<ImageView>(R.id.btnBack)
        val spinner = v.findViewById<Spinner>(R.id.reciterSpinner)
        spinner.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, QuranData.reciters.map { it.name })
        spinner.setSelection(0)
        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(p: AdapterView<*>?, vw: View?, pos: Int, id: Long) { selectedReciterIndex = pos }
            override fun onNothingSelected(p: AdapterView<*>?) {}
        }
        fun loadPage() {
            val surah = QuranData.getSurahByPage(currentPage)
            title.text = "سورة " + surah.name
            pageInfo.text = currentPage.toString() + " / 604"
            pageLoading.visibility = View.VISIBLE
            Glide.with(this).load(QuranData.getPageImageUrl(currentPage))
                .into(object : com.bumptech.glide.request.target.CustomTarget<android.graphics.drawable.Drawable>() {
                    override fun onResourceReady(r: android.graphics.drawable.Drawable, t: com.bumptech.glide.request.transition.Transition<in android.graphics.drawable.Drawable>?) {
                        pageImage.setImageDrawable(r); pageLoading.visibility = View.GONE
                        Prefs.setLastReadPage(requireContext(), currentPage)
                        Prefs.recordPageRead(requireContext())
                    }
                    override fun onLoadCleared(p: android.graphics.drawable.Drawable?) {}
                    override fun onLoadFailed(e: android.graphics.drawable.Drawable?) { pageLoading.visibility = View.GONE }
                })
        }
        loadPage()
        btnPrev.setOnClickListener { if (currentPage > 1) { currentPage--; loadPage() } }
        btnNext.setOnClickListener { if (currentPage < 604) { currentPage++; loadPage() } }
        btnBack.setOnClickListener { parentFragmentManager.popBackStack() }
        btnPlay.setOnClickListener {
            if (isPlaying) {
                mediaPlayer?.stop(); mediaPlayer?.release(); mediaPlayer = null; isPlaying = false
                btnPlay.setImageResource(R.drawable.ic_play)
            } else {
                val surah = QuranData.getSurahByPage(currentPage)
                val reciter = QuranData.reciters[selectedReciterIndex]
                val url = QuranData.getAudioUrl(reciter, surah.n)
                val mp = MediaPlayer()
                mp.setDataSource(url)
                mp.setOnPreparedListener { mp.start(); this@ReaderFragment.isPlaying = true; btnPlay.setImageResource(R.drawable.ic_pause) }
                mp.setOnCompletionListener { this@ReaderFragment.isPlaying = false; btnPlay.setImageResource(R.drawable.ic_play) }
                mp.setOnErrorListener { _, _, _ -> this@ReaderFragment.isPlaying = false; btnPlay.setImageResource(R.drawable.ic_play); true }
                mp.prepareAsync(); mediaPlayer = mp
            }
        }
        v.findViewById<ImageView>(R.id.btnTafsir).setOnClickListener {
            val surah = QuranData.getSurahByPage(currentPage)
            val dialog = com.google.android.material.bottomsheet.BottomSheetDialog(requireContext())
            val tv = TextView(requireContext()).apply {
                text = "جاري تحميل تفسير سورة " + surah.name + "..."
                textSize = 16f; setPadding(32,32,32,32)
                setTextColor(resources.getColor(R.color.text_primary, null))
            }
            dialog.setContentView(tv); dialog.show()
            Thread {
                try {
                    val url = java.net.URL("https://api.alquran.cloud/v1/surah/" + surah.n + "/ar.muyassar")
                    val conn = url.openConnection() as java.net.HttpURLConnection
                    val json = conn.inputStream.bufferedReader().readText()
                    val obj = com.google.gson.JsonParser.parseString(json).asJsonObject
                    val ayahs = obj.getAsJsonObject("data").getAsJsonArray("ayahs")
                    val sb = StringBuilder()
                    for (i in 0 until ayahs.size()) {
                        val a = ayahs[i].asJsonObject
                        sb.append("(").append(a.get("numberInSurah").asInt).append(") ").append(a.get("text").asString).append("\n\n")
                    }
                    activity?.runOnUiThread { tv.text = sb.toString() }
                } catch (e: Exception) { activity?.runOnUiThread { tv.text = "خطأ في تحميل التفسير" } }
            }.start()
        }
        return v
    }

    override fun onDestroyView() { super.onDestroyView(); mediaPlayer?.release(); mediaPlayer = null }
}
K13

echo "✅ Surah + Reader written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/PrayerFragment.kt << 'K14'
package tech.meshari.quran.ui

import android.Manifest
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import com.google.android.material.button.MaterialButton
import com.google.gson.JsonParser
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class PrayerFragment : Fragment() {
    private var timings: Map<String, String> = emptyMap()
    private val handler = Handler(Looper.getMainLooper())
    private var ticker: Runnable? = null
    private var rootView: View? = null

    private val keys = listOf("Fajr","Sunrise","Dhuhr","Asr","Maghrib","Isha")
    private val ar = listOf("الفجر","الشروق","الظهر","العصر","المغرب","العشاء")
    private val icons = listOf(R.drawable.ic_moon, R.drawable.ic_sun, R.drawable.ic_sun, R.drawable.ic_sun, R.drawable.ic_sun, R.drawable.ic_moon)

    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val v = inflater.inflate(R.layout.fragment_prayer, c, false)
        rootView = v
        v.findViewById<View>(R.id.btnQiblaSmall).setOnClickListener {
            (activity as? MainActivity)?.pushFragment(QiblaFragment())
        }
        v.findViewById<MaterialButton>(R.id.btnUseLocation).setOnClickListener { useLocation() }
        v.findViewById<MaterialButton>(R.id.btnCitySearch).setOnClickListener {
            val name = v.findViewById<EditText>(R.id.cityEdit).text.toString().trim()
            if (name.isNotEmpty()) lookupCity(name)
        }
        useLocation()
        return v
    }

    override fun onResume() { super.onResume(); startTicker() }
    override fun onPause() { super.onPause(); stopTicker() }

    private fun useLocation() {
        val ctx = requireContext()
        if (ActivityCompat.checkSelfPermission(ctx, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            val lm = ctx.getSystemService(android.content.Context.LOCATION_SERVICE) as LocationManager
            val loc = lm.getLastKnownLocation(LocationManager.NETWORK_PROVIDER) ?: lm.getLastKnownLocation(LocationManager.GPS_PROVIDER)
            if (loc != null) loadByLatLon(loc.latitude, loc.longitude) else loadByLatLon(24.7136, 46.6753)
        } else {
            requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 100)
            loadByLatLon(24.7136, 46.6753)
        }
    }

    private fun lookupCity(name: String) {
        Thread {
            try {
                val url = java.net.URL("https://nominatim.openstreetmap.org/search?format=json&q=" + java.net.URLEncoder.encode(name, "UTF-8") + "&limit=1")
                val conn = url.openConnection() as java.net.HttpURLConnection
                conn.setRequestProperty("User-Agent", "QuranApp/5.0")
                val resp = conn.inputStream.bufferedReader().readText()
                val arr = JsonParser.parseString(resp).asJsonArray
                if (arr.size() > 0) {
                    val o = arr[0].asJsonObject
                    val lat = o.get("lat").asDouble; val lon = o.get("lon").asDouble
                    activity?.runOnUiThread { loadByLatLon(lat, lon) }
                }
            } catch (e: Exception) {}
        }.start()
    }

    private fun loadByLatLon(lat: Double, lon: Double) {
        val loading = rootView?.findViewById<ProgressBar>(R.id.prayerLoading)
        loading?.visibility = View.VISIBLE
        Thread {
            try {
                val url = java.net.URL("https://api.aladhan.com/v1/timings?latitude=" + lat + "&longitude=" + lon + "&method=4")
                val json = url.openConnection().getInputStream().bufferedReader().readText()
                val data = JsonParser.parseString(json).asJsonObject.getAsJsonObject("data")
                val tt = data.getAsJsonObject("timings")
                val date = data.getAsJsonObject("date")
                val hijri = date.getAsJsonObject("hijri")
                val greg = date.getAsJsonObject("gregorian")
                val map = mutableMapOf<String, String>()
                keys.forEach { map[it] = tt.get(it).asString }
                val hijriText = hijri.get("day").asString + " " + hijri.getAsJsonObject("month").get("ar").asString + " " + hijri.get("year").asString + " هـ"
                val gregText = greg.get("day").asString + " " + greg.getAsJsonObject("month").get("en").asString + " " + greg.get("year").asString
                val dayAr = arrayOf("الأحد","الإثنين","الثلاثاء","الأربعاء","الخميس","الجمعة","السبت")
                val dayName = dayAr[(java.util.Calendar.getInstance().get(java.util.Calendar.DAY_OF_WEEK) - 1).coerceIn(0,6)]
                activity?.runOnUiThread {
                    timings = map
                    loading?.visibility = View.GONE
                    rootView?.findViewById<TextView>(R.id.prayerHijriDate)?.text = hijriText
                    rootView?.findViewById<TextView>(R.id.prayerGregDate)?.text = gregText
                    rootView?.findViewById<TextView>(R.id.prayerDayName)?.text = dayName
                    renderList()
                    startTicker()
                }
            } catch (e: Exception) { activity?.runOnUiThread { loading?.visibility = View.GONE } }
        }.start()
    }

    private fun renderList() {
        val v = rootView ?: return
        val container = v.findViewById<LinearLayout>(R.id.prayerList)
        container.removeAllViews()
        val nextIdx = nextPrayerIndex()
        for (i in keys.indices) {
            val row = LayoutInflater.from(requireContext()).inflate(R.layout.item_prayer_row, container, false)
            row.findViewById<TextView>(R.id.prayerName).text = ar[i]
            row.findViewById<TextView>(R.id.prayerTime).text = formatTime12(timings[keys[i]] ?: "")
            row.findViewById<ImageView>(R.id.prayerIcon).setImageResource(icons[i])
            row.findViewById<TextView>(R.id.prayerNext).visibility = if (i == nextIdx) View.VISIBLE else View.GONE
            container.addView(row)
        }
        v.findViewById<TextView>(R.id.prayerNextName).text = ar[nextIdx]
        v.findViewById<ImageView>(R.id.prayerNextIcon).setImageResource(icons[nextIdx])
    }

    private fun nextPrayerIndex(): Int {
        if (timings.isEmpty()) return 0
        val cal = java.util.Calendar.getInstance()
        val nowMin = cal.get(java.util.Calendar.HOUR_OF_DAY) * 60 + cal.get(java.util.Calendar.MINUTE)
        for (i in keys.indices) {
            val t = timings[keys[i]] ?: continue
            val parts = t.split(" ")[0].split(":")
            val tm = (parts[0].toIntOrNull() ?: 0) * 60 + (parts[1].toIntOrNull() ?: 0)
            if (tm > nowMin) return i
        }
        return 0
    }

    private fun startTicker() {
        stopTicker()
        val r = object : Runnable {
            override fun run() { tick(); handler.postDelayed(this, 1000) }
        }
        ticker = r; handler.post(r)
    }
    private fun stopTicker() { ticker?.let { handler.removeCallbacks(it) }; ticker = null }

    private fun tick() {
        val v = rootView ?: return
        val now = SimpleDateFormat("hh:mm:ss a", Locale.US).format(Date())
        v.findViewById<TextView>(R.id.prayerClock).text = now
        if (timings.isEmpty()) return
        val idx = nextPrayerIndex()
        val t = timings[keys[idx]] ?: return
        val parts = t.split(" ")[0].split(":")
        val targetMin = (parts[0].toIntOrNull() ?: 0) * 60 + (parts[1].toIntOrNull() ?: 0)
        val cal = java.util.Calendar.getInstance()
        val nowSec = cal.get(java.util.Calendar.HOUR_OF_DAY) * 3600 + cal.get(java.util.Calendar.MINUTE) * 60 + cal.get(java.util.Calendar.SECOND)
        var rem = targetMin * 60 - nowSec
        if (rem < 0) rem += 24 * 3600
        v.findViewById<TextView>(R.id.prayerCountdown).text = String.format(Locale.US, "%d:%02d:%02d", rem/3600, (rem%3600)/60, rem%60)
    }

    private fun formatTime12(s: String): String {
        return try {
            val parts = s.split(" ")[0].split(":")
            val h24 = parts[0].toInt(); val m = parts[1].toInt()
            val ampm = if (h24 < 12) "AM" else "PM"
            val h12 = ((h24 + 11) % 12) + 1
            String.format(Locale.US, "%d:%02d %s", h12, m, ampm)
        } catch (e: Exception) { s }
    }
}
K14

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/QiblaFragment.kt << 'K15'
package tech.meshari.quran.ui

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import tech.meshari.quran.R

class QiblaFragment : Fragment(), SensorEventListener {
    private var sensorManager: SensorManager? = null
    private var qiblaDirection: TextView? = null
    private var qiblaDegrees: TextView? = null
    private val qiblaAngle = 245.0
    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_qibla, c, false)
        qiblaDirection = view.findViewById(R.id.qiblaDirection)
        qiblaDegrees = view.findViewById(R.id.qiblaDegrees)
        sensorManager = requireContext().getSystemService(Context.SENSOR_SERVICE) as SensorManager
        return view
    }
    override fun onResume() { super.onResume(); sensorManager?.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)?.let { sensorManager?.registerListener(this, it, SensorManager.SENSOR_DELAY_UI) } }
    override fun onPause() { super.onPause(); sensorManager?.unregisterListener(this) }
    override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor.type == Sensor.TYPE_ROTATION_VECTOR) {
            val rotMatrix = FloatArray(9); val orientation = FloatArray(3)
            SensorManager.getRotationMatrixFromVector(rotMatrix, event.values)
            SensorManager.getOrientation(rotMatrix, orientation)
            val azimuth = Math.toDegrees(orientation[0].toDouble())
            val bearing = (qiblaAngle - azimuth + 360) % 360
            qiblaDirection?.rotation = bearing.toFloat()
            qiblaDegrees?.text = String.format("%.0f°", bearing)
        }
    }
    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
}
K15

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/BookmarksFragment.kt << 'K16'
package tech.meshari.quran.ui

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import tech.meshari.quran.data.QuranData

class BookmarksFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_bookmarks, c, false)
        val recycler = view.findViewById<RecyclerView>(R.id.bookmarksRecycler)
        val empty = view.findViewById<TextView>(R.id.emptyBookmarks)
        val prefs = requireContext().getSharedPreferences("quran_prefs", Context.MODE_PRIVATE)
        val bookmarksStr = prefs.getString("bookmarks", "") ?: ""
        val bookmarks = if (bookmarksStr.isNotEmpty()) bookmarksStr.split(",").mapNotNull { it.toIntOrNull() } else emptyList()
        if (bookmarks.isEmpty()) { empty.visibility = View.VISIBLE; recycler.visibility = View.GONE }
        else {
            recycler.layoutManager = LinearLayoutManager(requireContext())
            recycler.adapter = object : RecyclerView.Adapter<RecyclerView.ViewHolder>() {
                override fun getItemCount() = bookmarks.size
                override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
                    val tv = TextView(parent.context).apply {
                        textSize = 16f; setPadding(20,16,20,16)
                        setTextColor(resources.getColor(R.color.text_primary, null))
                        setBackgroundResource(R.drawable.card_bg)
                        val lp = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
                        lp.bottomMargin = 10; layoutParams = lp
                    }
                    return object : RecyclerView.ViewHolder(tv) {}
                }
                override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
                    val page = bookmarks[position]; val surah = QuranData.getSurahByPage(page)
                    (holder.itemView as TextView).text = "📖 صفحة " + page + " - سورة " + surah.name
                    holder.itemView.setOnClickListener { (activity as? MainActivity)?.openReader(surah.n, page) }
                }
            }
        }
        return view
    }
}
K16

echo "✅ Prayer + Qibla + Bookmarks written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/MoreFragment.kt << 'K17'
package tech.meshari.quran.ui

import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView
import androidx.fragment.app.Fragment
import tech.meshari.quran.AboutActivity
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R

class MoreFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val sv = ScrollView(requireContext()).apply { setBackgroundColor(resources.getColor(R.color.bg, null)) }
        val ll = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.VERTICAL; setPadding(28, 32, 28, 32)
        }
        ll.addView(ImageView(requireContext()).apply {
            setImageResource(R.drawable.app_logo)
            layoutParams = LinearLayout.LayoutParams(160, 160).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 16 }
        })
        ll.addView(TextView(requireContext()).apply {
            text = "المزيد"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 24f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 24)
        })
        fun makeCard(icon: String, title: String, subtitle: String, onClick: () -> Unit): View {
            val card = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.HORIZONTAL; setPadding(20, 18, 20, 18)
                setBackgroundResource(R.drawable.card_bg)
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 12 }
                setOnClickListener { onClick() }
            }
            val iconTv = TextView(requireContext()).apply { text = icon; textSize = 28f; setPadding(0, 0, 16, 0) }
            val textContainer = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.VERTICAL
                layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
            }
            textContainer.addView(TextView(requireContext()).apply { text = title; setTextColor(resources.getColor(R.color.text_primary, null)); textSize = 17f; setTypeface(null, Typeface.BOLD) })
            textContainer.addView(TextView(requireContext()).apply { text = subtitle; setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 12f; setPadding(0, 4, 0, 0) })
            val arrow = TextView(requireContext()).apply { text = "◀"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 16f }
            card.addView(iconTv); card.addView(textContainer); card.addView(arrow)
            return card
        }
        ll.addView(makeCard("📜", "فتاوى إسلامية", "أحكام وفتاوى شرعية من مصادر موثوقة") {
            (activity as? MainActivity)?.pushFragment(FatwaFragment())
        })
        ll.addView(makeCard("🧮", "حاسبة الزكاة", "احسب زكاة المال والذهب والفضة") {
            (activity as? MainActivity)?.pushFragment(ZakatFragment())
        })
        ll.addView(makeCard("📌", "المحفوظات", "صفحات القرآن المحفوظة") {
            (activity as? MainActivity)?.pushFragment(BookmarksFragment())
        })
        ll.addView(makeCard("🧭", "اتجاه القبلة", "بوصلة لتحديد اتجاه القبلة") {
            (activity as? MainActivity)?.pushFragment(QiblaFragment())
        })
        ll.addView(makeCard("ℹ️", "حول التطبيق", "معلومات عن التطبيق والمطور") {
            startActivity(Intent(requireContext(), AboutActivity::class.java))
        })
        sv.addView(ll)
        return sv
    }
}
K17

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/FatwaFragment.kt << 'K18'
package tech.meshari.quran.ui

import android.graphics.Typeface
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import tech.meshari.quran.R

class FatwaFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val sv = ScrollView(requireContext()).apply { setBackgroundColor(resources.getColor(R.color.bg, null)) }
        val ll = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.VERTICAL; setPadding(28, 32, 28, 32)
        }
        ll.addView(TextView(requireContext()).apply {
            text = "📜 فتاوى إسلامية"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 22f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 8)
        })
        ll.addView(TextView(requireContext()).apply {
            text = "أحكام وفتاوى شرعية من مصادر موثوقة"
            setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 13f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 24)
        })
        val categories = listOf(
            "🕌" to "الصلاة" to "أحكام الصلاة والطهارة",
            "🌙" to "الصيام" to "أحكام الصيام وشهر رمضان",
            "💰" to "الزكاة" to "أحكام الزكاة والصدقات",
            "🕋" to "الحج والعمرة" to "أحكام الحج والعمرة والمناسك",
            "🤝" to "المعاملات" to "أحكام البيع والشراء والتجارة",
            "👨‍👩‍👧‍👦" to "الأسرة" to "أحكام الزواج والطلاق والنفقة",
            "📖" to "العقيدة" to "أصول العقيدة الإسلامية",
            "🤲" to "الأذكار والأدعية" to "أذكار اليوم والليلة والأدعية المأثورة"
        )
        categories.forEach { (iconTitle, desc) ->
            val (icon, title) = iconTitle
            val card = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.HORIZONTAL; setPadding(20, 18, 20, 18)
                setBackgroundResource(R.drawable.card_bg)
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 12 }
                setOnClickListener { Toast.makeText(requireContext(), "قريباً - " + title, Toast.LENGTH_SHORT).show() }
            }
            val iconTv = TextView(requireContext()).apply { text = icon; textSize = 26f; setPadding(0, 0, 16, 0) }
            val textCont = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.VERTICAL
                layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
            }
            textCont.addView(TextView(requireContext()).apply { text = title; setTextColor(resources.getColor(R.color.text_primary, null)); textSize = 16f; setTypeface(null, Typeface.BOLD) })
            textCont.addView(TextView(requireContext()).apply { text = desc; setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 12f; setPadding(0, 4, 0, 0) })
            val arrow = TextView(requireContext()).apply { text = "◀"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 16f }
            card.addView(iconTv); card.addView(textCont); card.addView(arrow)
            ll.addView(card)
        }
        sv.addView(ll)
        return sv
    }
}
K18

echo "✅ More + Fatwa written"

cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/ZakatFragment.kt << 'K19'
package tech.meshari.quran.ui

import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import tech.meshari.quran.R
import org.json.JSONObject
import java.net.URL

class ZakatFragment : Fragment() {
    private var goldPrice24 = 0.0
    private var silverPrice = 0.0
    private val goldEntries = mutableListOf<Pair<EditText, Spinner>>()
    private var moneyInput: EditText? = null
    private var silverInput: EditText? = null
    private var resultText: TextView? = null
    private var goldContainer: LinearLayout? = null
    private var goldPriceText: TextView? = null
    private var silverPriceText: TextView? = null
    private var priceStatusText: TextView? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val ctx = requireContext()
        val sv = ScrollView(ctx).apply { setBackgroundColor(resources.getColor(R.color.bg, null)) }
        val ll = LinearLayout(ctx).apply { orientation = LinearLayout.VERTICAL; setPadding(28, 32, 28, 32) }
        ll.addView(TextView(ctx).apply {
            text = "🧮 حاسبة الزكاة"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 22f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 8)
        })
        ll.addView(TextView(ctx).apply {
            text = "احسب زكاة أموالك بدقة"; setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 13f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 16)
        })
        priceStatusText = TextView(ctx).apply {
            text = "⏳ جاري تحميل أسعار الذهب والفضة..."; setTextColor(resources.getColor(R.color.primary, null)); textSize = 12f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 16)
        }
        ll.addView(priceStatusText)

        fun sectionTitle(text: String): TextView {
            return TextView(ctx).apply {
                this.text = text; setTextColor(resources.getColor(R.color.primary, null)); textSize = 16f
                setTypeface(null, Typeface.BOLD); setPadding(0, 20, 0, 10)
            }
        }
        fun makeInput(hint: String): EditText {
            return EditText(ctx).apply {
                this.hint = hint; setHintTextColor(resources.getColor(R.color.text_secondary, null))
                setTextColor(resources.getColor(R.color.text_primary, null))
                textSize = 15f; setBackgroundResource(R.drawable.card_bg); setPadding(20, 16, 20, 16)
                inputType = android.text.InputType.TYPE_CLASS_NUMBER or android.text.InputType.TYPE_NUMBER_FLAG_DECIMAL
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 10 }
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
                    override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) {}
                    override fun afterTextChanged(s: Editable?) { calculateZakat() }
                })
            }
        }

        ll.addView(sectionTitle("💵 زكاة المال"))
        moneyInput = makeInput("المبلغ بالريال السعودي"); ll.addView(moneyInput)

        ll.addView(sectionTitle("🥇 زكاة الذهب"))
        goldPriceText = TextView(ctx).apply { text = "سعر الذهب 24: جاري التحميل..."; setTextColor(resources.getColor(R.color.primary, null)); textSize = 13f; setPadding(0, 0, 0, 8) }
        ll.addView(goldPriceText)
        goldContainer = LinearLayout(ctx).apply { orientation = LinearLayout.VERTICAL }
        ll.addView(goldContainer); addGoldEntry()

        val addGoldBtn = Button(ctx).apply {
            text = "➕ إضافة ذهب آخر"; setTextColor(resources.getColor(R.color.primary, null))
            setBackgroundResource(R.drawable.reset_btn_bg)
            textSize = 13f; setPadding(20, 10, 20, 10)
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 14 }
            setOnClickListener { addGoldEntry() }
        }
        ll.addView(addGoldBtn)

        ll.addView(sectionTitle("🥈 زكاة الفضة"))
        silverPriceText = TextView(ctx).apply { text = "سعر الفضة: جاري التحميل..."; setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 13f; setPadding(0, 0, 0, 8) }
        ll.addView(silverPriceText)
        silverInput = makeInput("وزن الفضة بالجرام"); ll.addView(silverInput)

        ll.addView(View(ctx).apply {
            setBackgroundColor(resources.getColor(R.color.divider, null))
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 2).apply { topMargin = 20; bottomMargin = 20 }
        })
        resultText = TextView(ctx).apply {
            text = "جاري تحميل الأسعار..."; setTextColor(resources.getColor(R.color.primary, null)); textSize = 18f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 14, 0, 14)
        }
        ll.addView(resultText)
        ll.addView(TextView(ctx).apply {
            text = "\n📌 ملاحظات:\n• نصاب المال: 85 جرام ذهب عيار 24\n• نصاب الفضة: 595 جرام فضة\n• نسبة الزكاة: 2.5%"
            setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 12f; setPadding(0, 20, 0, 0)
        })
        sv.addView(ll); fetchPrices(); return sv
    }

    private fun fetchPrices() {
        Thread {
            try {
                val rateJson = URL("https://api.exchangerate-api.com/v4/latest/USD").readText()
                val sarRate = JSONObject(rateJson).getJSONObject("rates").getDouble("SAR")
                val goldJson = URL("https://api.gold-api.com/price/XAU").readText()
                val goldUsdOz = JSONObject(goldJson).getDouble("price")
                goldPrice24 = (goldUsdOz / 31.1035) * sarRate
                val silverJson = URL("https://api.gold-api.com/price/XAG").readText()
                val silverUsdOz = JSONObject(silverJson).getDouble("price")
                silverPrice = (silverUsdOz / 31.1035) * sarRate
                activity?.runOnUiThread {
                    goldPriceText?.text = "سعر الذهب 24: " + String.format("%.2f", goldPrice24) + " ر.س / جرام"
                    silverPriceText?.text = "سعر الفضة: " + String.format("%.2f", silverPrice) + " ر.س / جرام"
                    priceStatusText?.text = "✅ الأسعار محدثة مباشرة من السوق العالمي"
                    resultText?.text = "أدخل البيانات لحساب الزكاة"; calculateZakat()
                }
            } catch (e: Exception) {
                goldPrice24 = 591.0; silverPrice = 9.3
                activity?.runOnUiThread {
                    goldPriceText?.text = "سعر الذهب 24: " + String.format("%.2f", goldPrice24) + " ر.س (تقريبي)"
                    silverPriceText?.text = "سعر الفضة: " + String.format("%.2f", silverPrice) + " ر.س (تقريبي)"
                    priceStatusText?.text = "⚠️ تعذر تحميل الأسعار - يتم استخدام أسعار تقريبية"
                    resultText?.text = "أدخل البيانات لحساب الزكاة"; calculateZakat()
                }
            }
        }.start()
    }

    private fun addGoldEntry() {
        val ctx = requireContext()
        val row = LinearLayout(ctx).apply {
            orientation = LinearLayout.HORIZONTAL
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 8 }
        }
        val input = EditText(ctx).apply {
            hint = "الوزن بالجرام"; setHintTextColor(resources.getColor(R.color.text_secondary, null))
            setTextColor(resources.getColor(R.color.text_primary, null))
            textSize = 14f; setBackgroundResource(R.drawable.card_bg); setPadding(16, 12, 16, 12)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER or android.text.InputType.TYPE_NUMBER_FLAG_DECIMAL
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f).apply { marginEnd = 8 }
            addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
                override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) {}
                override fun afterTextChanged(s: Editable?) { calculateZakat() }
            })
        }
        val spinner = Spinner(ctx).apply {
            adapter = ArrayAdapter(ctx, android.R.layout.simple_spinner_dropdown_item, arrayOf("عيار 24", "عيار 21", "عيار 18"))
            setBackgroundResource(R.drawable.card_bg)
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 0.7f)
            onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(p: AdapterView<*>?, v: View?, pos: Int, id: Long) { calculateZakat() }
                override fun onNothingSelected(p: AdapterView<*>?) {}
            }
        }
        row.addView(input); row.addView(spinner)
        goldContainer?.addView(row); goldEntries.add(Pair(input, spinner))
    }

    private fun calculateZakat() {
        if (goldPrice24 == 0.0) return
        var totalValue = 0.0
        totalValue += moneyInput?.text?.toString()?.toDoubleOrNull() ?: 0.0
        for ((input, spinner) in goldEntries) {
            val weight = input.text.toString().toDoubleOrNull() ?: 0.0
            val karatFactor = when (spinner.selectedItemPosition) { 0 -> 1.0; 1 -> 21.0 / 24.0; 2 -> 18.0 / 24.0; else -> 1.0 }
            totalValue += weight * karatFactor * goldPrice24
        }
        val silverWeight = silverInput?.text?.toString()?.toDoubleOrNull() ?: 0.0
        totalValue += silverWeight * silverPrice
        val nisab = 85 * goldPrice24
        if (totalValue >= nisab) {
            val zakat = totalValue * 0.025
            resultText?.text = "💰 إجمالي الأصول: " + String.format("%,.2f", totalValue) + " ر.س\n✅ الزكاة المستحقة: " + String.format("%,.2f", zakat) + " ر.س"
            resultText?.setTextColor(Color.parseColor("#4CAF50"))
        } else if (totalValue > 0) {
            resultText?.text = "إجمالي: " + String.format("%,.2f", totalValue) + " ر.س\n❌ لم يبلغ النصاب (" + String.format("%,.0f", nisab) + " ر.س)"
            resultText?.setTextColor(Color.parseColor("#F4A549"))
        } else {
            resultText?.text = "أدخل البيانات لحساب الزكاة"
            resultText?.setTextColor(resources.getColor(R.color.primary, null))
        }
    }
}
K19

cat > $PROJECT/app/src/main/java/$PKG_PATH/AboutActivity.kt << 'K20'
package tech.meshari.quran

import android.os.Bundle
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView
import android.widget.LinearLayout
import android.widget.ImageView
import android.widget.Button
import android.widget.ScrollView
import android.graphics.Typeface
import android.view.Gravity
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT

class AboutActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val sv = ScrollView(this).apply { setBackgroundColor(resources.getColor(R.color.bg, null)) }
        val ll = LinearLayout(this).apply { orientation = LinearLayout.VERTICAL; gravity = Gravity.CENTER_HORIZONTAL; setPadding(40, 60, 40, 60) }
        val logo = ImageView(this).apply { setImageResource(R.drawable.app_logo); layoutParams = LinearLayout.LayoutParams(220, 220).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 24 } }
        ll.addView(logo)
        ll.addView(TextView(this).apply { text = "القرآن الكريم"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 26f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 12) })
        ll.addView(TextView(this).apply { text = "❤ صدقة جارية ❤"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 20f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 12, 0, 20) })
        ll.addView(TextView(this).apply {
            text = "تطبيق القرآن الكريم هو صدقة جارية لوجه الله تعالى.\n\nنسأل الله أن يجعل هذا العمل خالصاً لوجهه الكريم وأن يجعله في ميزان حسنات كل من ساهم فيه."
            setTextColor(resources.getColor(R.color.text_primary, null)); textSize = 15f; gravity = Gravity.CENTER; setLineSpacing(6f, 1.2f); setPadding(0, 0, 0, 32)
        })
        ll.addView(android.view.View(this).apply { setBackgroundColor(resources.getColor(R.color.divider, null)); layoutParams = LinearLayout.LayoutParams(MATCH_PARENT, 2).apply { bottomMargin = 24; topMargin = 8 } })
        ll.addView(TextView(this).apply { text = "الإصدار: 5.0.0"; setTextColor(resources.getColor(R.color.text_secondary, null)); textSize = 13f; gravity = Gravity.CENTER; setPadding(0, 0, 0, 24) })
        ll.addView(TextView(this).apply { text = "للتواصل مع المطور"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 16f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 14) })
        ll.addView(Button(this).apply {
            text = "📱 +966555877723"; setTextColor(resources.getColor(android.R.color.white, null))
            setBackgroundColor(resources.getColor(R.color.primary, null)); textSize = 16f; setPadding(40, 18, 40, 18)
            layoutParams = LinearLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 16 }
            setOnClickListener { startActivity(Intent(Intent.ACTION_DIAL, Uri.parse("tel:+966555877723"))) }
        })
        ll.addView(Button(this).apply {
            text = "💬 واتساب"; setTextColor(resources.getColor(android.R.color.white, null))
            setBackgroundColor(resources.getColor(R.color.adhkar_green, null)); textSize = 16f; setPadding(40, 18, 40, 18)
            layoutParams = LinearLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 32 }
            setOnClickListener { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://wa.me/966555877723"))) }
        })
        ll.addView(TextView(this).apply { text = "اللهم اجعل هذا العمل في ميزان حسناتنا يوم القيامة"; setTextColor(resources.getColor(R.color.primary, null)); textSize = 13f; gravity = Gravity.CENTER; setTypeface(null, Typeface.ITALIC) })
        sv.addView(ll); setContentView(sv)
        supportActionBar?.apply { title = "حول التطبيق"; setDisplayHomeAsUpEnabled(true) }
    }
    override fun onSupportNavigateUp(): Boolean { onBackPressed(); return true }
}
K20

cat > $PROJECT/app/proguard-rules.pro << 'PROGUARD'
-keep class tech.meshari.quran.data.** { *; }
-keep class com.google.gson.** { *; }
-dontwarn okhttp3.**
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
PROGUARD

cat > $PROJECT/gradle.properties << 'GRADLEPROPS'
android.useAndroidX=true
org.gradle.jvmargs=-Xmx2048m
GRADLEPROPS

echo "✅ Quran Android app v5.0.0 created - iPhone style!"
echo "📱 Package: tech.meshari.quran"
echo "🎨 Theme: Light cream/gold (iPhone-style)"
echo "🆕 Home dashboard + Adhkar + restyled screens"
