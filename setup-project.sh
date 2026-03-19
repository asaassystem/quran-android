#!/bin/bash
set -e

PROJECT="quran-app"
PKG="tech.meshari.quran"
PKG_PATH="tech/meshari/quran"

mkdir -p $PROJECT/app/src/main/java/$PKG_PATH
mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/data
mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/ui
mkdir -p $PROJECT/app/src/main/java/$PKG_PATH/api
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
mkdir -p $PROJECT/app/src/main/res/font
mkdir -p $PROJECT/gradle/wrapper

# Download logo
curl -sL "https://quran.meshari.tech/logoo.png" -o $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
for d in xxhdpi xhdpi hdpi mdpi; do
    cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-${d}/ic_launcher.png
    cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-${d}/ic_launcher_round.png
done
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png
cp $PROJECT/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png $PROJECT/app/src/main/res/drawable/app_logo.png

# ========== settings.gradle.kts ==========
cat > $PROJECT/settings.gradle.kts << 'SETTINGS'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "QuranApp"
include(":app")
SETTINGS

# ========== build.gradle.kts (root) ==========
cat > $PROJECT/build.gradle.kts << 'ROOTBUILD'
plugins {
    id("com.android.application") version "8.2.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}
ROOTBUILD

# ========== app/build.gradle.kts ==========
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
        versionCode = 7
        versionName = "4.3.0"
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

# ========== AndroidManifest.xml ==========
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

# ========== colors.xml (BLUE THEME - NO GREEN) ==========
cat > $PROJECT/app/src/main/res/values/colors.xml << 'COLORS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="primary">#0A1628</color>
    <color name="primary_dark">#060E1A</color>
    <color name="primary_variant">#132D54</color>
    <color name="accent">#C8A84E</color>
    <color name="accent_light">#E8D59A</color>
    <color name="gold">#D4A847</color>
    <color name="gold_dark">#B8922E</color>
    <color name="bg_dark">#0A1929</color>
    <color name="bg_card">#132F4C</color>
    <color name="bg_card_light">#1A3D5C</color>
    <color name="text_primary">#FFFFFF</color>
    <color name="text_secondary">#B0BEC5</color>
    <color name="text_gold">#D4A847</color>
    <color name="surface">#11273E</color>
    <color name="divider">#1E3A5F</color>
    <color name="surah_number_bg">#D4A847</color>
    <color name="meccan_badge">#4CAF50</color>
    <color name="medinan_badge">#2196F3</color>
    <color name="bottom_nav_bg">#0D2137</color>
    <color name="ripple_gold">#33D4A847</color>
</resources>
COLORS

# ========== themes.xml ==========
cat > $PROJECT/app/src/main/res/values/themes.xml << 'THEMES'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="AppTheme" parent="Theme.Material3.Dark.NoActionBar">
        <item name="colorPrimary">@color/primary</item>
        <item name="colorPrimaryDark">@color/primary_dark</item>
        <item name="colorAccent">@color/accent</item>
        <item name="android:windowBackground">@color/bg_dark</item>
        <item name="android:statusBarColor">@color/primary_dark</item>
        <item name="android:navigationBarColor">@color/bottom_nav_bg</item>
        <item name="android:fontFamily">sans-serif</item>
    </style>
    <style name="SplashTheme" parent="Theme.Material3.Dark.NoActionBar">
        <item name="android:windowBackground">@color/primary_dark</item>
        <item name="android:statusBarColor">@color/primary_dark</item>
        <item name="android:navigationBarColor">@color/primary_dark</item>
    </style>
    <style name="GoldButton" parent="Widget.Material3.Button">
        <item name="backgroundTint">@color/gold</item>
        <item name="android:textColor">#0A1628</item>
        <item name="android:textSize">16sp</item>
        <item name="cornerRadius">25dp</item>
    </style>
</resources>
THEMES

# ========== strings.xml ==========
cat > $PROJECT/app/src/main/res/values/strings.xml << 'STRINGS'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">القرآن الكريم</string>
    <string name="tab_quran">القرآن</string>
    <string name="tab_prayer">الصلاة</string>
    <string name="tab_qibla">القبلة</string>
    <string name="tab_bookmarks">المحفوظات</string>
    <string name="tab_more">المزيد</string>
    <string name="tab_fatwa">فتاوى</string>
    <string name="tab_zakat">الزكاة</string>
    <string name="search_hint">ابحث في القرآن...</string>
    <string name="no_internet">لا يوجد اتصال بالإنترنت</string>
    <string name="loading">جاري التحميل...</string>
    <string name="retry">إعادة المحاولة</string>
    <string name="page_of">صفحة %1$d من 604</string>
    <string name="surah_list">فهرس السور</string>
    <string name="all">الكل</string>
    <string name="meccan">مكية</string>
    <string name="medinan">مدنية</string>
    <string name="ayahs">%d آية</string>
    <string name="tafsir">التفسير</string>
    <string name="select_reciter">اختر القارئ</string>
    <string name="fajr">الفجر</string>
    <string name="sunrise">الشروق</string>
    <string name="dhuhr">الظهر</string>
    <string name="asr">العصر</string>
    <string name="maghrib">المغرب</string>
    <string name="isha">العشاء</string>
</resources>
STRINGS

# ========== bottom_nav_menu.xml ==========
cat > $PROJECT/app/src/main/res/menu/bottom_nav.xml << 'MENU'
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@+id/nav_quran" android:icon="@android:drawable/ic_menu_agenda" android:title="@string/tab_quran"/>
    <item android:id="@+id/nav_prayer" android:icon="@android:drawable/ic_menu_my_calendar" android:title="@string/tab_prayer"/>
    <item android:id="@+id/nav_qibla" android:icon="@android:drawable/ic_menu_compass" android:title="@string/tab_qibla"/>
    <item android:id="@+id/nav_bookmarks" android:icon="@android:drawable/ic_menu_save" android:title="@string/tab_bookmarks"/>
    <item android:id="@+id/nav_more" android:icon="@android:drawable/ic_menu_more" android:title="@string/tab_more"/>
</menu>
MENU

# ========== activity_splash.xml ==========
cat > $PROJECT/app/src/main/res/layout/activity_splash.xml << 'SPLASHLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:background="@color/primary_dark">
    <ImageView android:id="@+id/splashLogo" android:layout_width="180dp" android:layout_height="180dp"
        android:src="@drawable/app_logo" android:alpha="0"/>
    <TextView android:id="@+id/splashTitle" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="القرآن الكريم" android:textColor="@color/gold" android:textSize="32sp"
        android:textStyle="bold" android:layout_marginTop="24dp" android:alpha="0"/>
    <TextView android:id="@+id/splashSubtitle" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="quran.meshari.tech" android:textColor="@color/text_secondary" android:textSize="14sp"
        android:layout_marginTop="8dp" android:alpha="0"/>
</LinearLayout>
SPLASHLAYOUT

# ========== activity_main.xml ==========
cat > $PROJECT/app/src/main/res/layout/activity_main.xml << 'MAINLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg_dark">
    <com.google.android.material.appbar.MaterialToolbar android:id="@+id/toolbar"
        android:layout_width="match_parent" android:layout_height="56dp"
        android:background="@color/primary" app:titleTextColor="@color/gold" app:title="القرآن الكريم"
        app:navigationIcon="@drawable/app_logo">
        <ImageView android:layout_width="32dp" android:layout_height="32dp"
            android:src="@drawable/app_logo" android:layout_gravity="end" android:layout_marginEnd="16dp"/>
    </com.google.android.material.appbar.MaterialToolbar>
    <FrameLayout android:id="@+id/fragmentContainer"
        android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"/>
    <com.google.android.material.bottomnavigation.BottomNavigationView android:id="@+id/bottomNav"
        android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/bottom_nav_bg" app:itemTextColor="@color/gold"
        app:itemIconTint="@color/gold" app:labelVisibilityMode="labeled" app:menu="@menu/bottom_nav"/>
</LinearLayout>
MAINLAYOUT

# ========== fragment_surah_list.xml ==========
cat > $PROJECT/app/src/main/res/layout/fragment_surah_list.xml << 'SURAHLISTLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg_dark">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:padding="16dp" android:background="@color/primary">
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content"
            android:text="🕌 القرآن الكريم" android:textColor="@color/gold" android:textSize="22sp"
            android:textStyle="bold" android:gravity="center"/>
        <EditText android:id="@+id/searchEdit" android:layout_width="match_parent" android:layout_height="48dp"
            android:layout_marginTop="12dp" android:hint="@string/search_hint"
            android:textColorHint="@color/text_secondary" android:textColor="@color/text_primary"
            android:background="@drawable/search_bg" android:paddingStart="16dp" android:paddingEnd="16dp"
            android:textSize="15sp" android:singleLine="true"
            android:drawableStart="@android:drawable/ic_menu_search" android:drawablePadding="8dp" android:inputType="text"/>
        <LinearLayout android:id="@+id/filterButtons" android:layout_width="match_parent"
            android:layout_height="wrap_content" android:gravity="center" android:layout_marginTop="8dp"
            android:orientation="horizontal">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnAll" style="@style/GoldButton"
                android:layout_width="wrap_content" android:layout_height="36dp" android:text="@string/all"
                android:textSize="13sp" android:layout_marginEnd="8dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnMeccan" style="@style/GoldButton"
                android:layout_width="wrap_content" android:layout_height="36dp" android:text="@string/meccan"
                android:textSize="13sp" android:layout_marginEnd="8dp" android:backgroundTint="@color/bg_card"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnMedinan" style="@style/GoldButton"
                android:layout_width="wrap_content" android:layout_height="36dp" android:text="@string/medinan"
                android:textSize="13sp" android:backgroundTint="@color/bg_card"/>
        </LinearLayout>
    </LinearLayout>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/surahRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent"
        android:padding="8dp" android:clipToPadding="false"/>
</LinearLayout>
SURAHLISTLAYOUT

# ========== item_surah.xml ==========
cat > $PROJECT/app/src/main/res/layout/item_surah.xml << 'ITEMSURAH'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_margin="4dp"
    app:cardBackgroundColor="@color/bg_card" app:cardCornerRadius="12dp" app:cardElevation="2dp" app:strokeWidth="0dp">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="horizontal" android:padding="14dp" android:gravity="center_vertical">
        <FrameLayout android:layout_width="44dp" android:layout_height="44dp">
            <View android:layout_width="44dp" android:layout_height="44dp" android:background="@drawable/circle_gold"/>
            <TextView android:id="@+id/surahNumber" android:layout_width="match_parent" android:layout_height="match_parent"
                android:gravity="center" android:textColor="@color/primary_dark" android:textSize="16sp" android:textStyle="bold"/>
        </FrameLayout>
        <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content" android:layout_weight="1"
            android:orientation="vertical" android:layout_marginStart="14dp" android:layout_marginEnd="8dp">
            <TextView android:id="@+id/surahNameAr" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_primary" android:textSize="18sp" android:textStyle="bold"/>
            <TextView android:id="@+id/surahNameEn" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_secondary" android:textSize="12sp"/>
        </LinearLayout>
        <LinearLayout android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:orientation="vertical" android:gravity="end">
            <TextView android:id="@+id/surahType" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/accent_light" android:textSize="11sp" android:background="@drawable/badge_bg"
                android:paddingStart="8dp" android:paddingEnd="8dp" android:paddingTop="2dp" android:paddingBottom="2dp"/>
            <TextView android:id="@+id/surahAyahs" android:layout_width="wrap_content" android:layout_height="wrap_content"
                android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_marginTop="4dp"/>
        </LinearLayout>
    </LinearLayout>
</com.google.android.material.card.MaterialCardView>
ITEMSURAH

# ========== fragment_reader.xml ==========
cat > $PROJECT/app/src/main/res/layout/fragment_reader.xml << 'READERLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg_dark">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/primary" android:padding="10dp" android:gravity="center_vertical"
        android:orientation="horizontal">
        <ImageView android:id="@+id/btnBack" android:layout_width="32dp" android:layout_height="32dp"
            android:src="@android:drawable/ic_menu_revert" android:padding="4dp"/>
        <TextView android:id="@+id/surahTitle" android:layout_width="0dp" android:layout_height="wrap_content"
            android:layout_weight="1" android:textColor="@color/gold" android:textSize="20sp"
            android:textStyle="bold" android:gravity="center"/>
        <TextView android:id="@+id/pageInfo" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/text_secondary" android:textSize="12sp"/>
    </LinearLayout>
    <FrameLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1">
        <ImageView android:id="@+id/quranPageImage" android:layout_width="match_parent"
            android:layout_height="match_parent" android:scaleType="fitCenter" android:background="#FFFFF8E1"/>
        <ProgressBar android:id="@+id/pageLoading" android:layout_width="48dp" android:layout_height="48dp"
            android:layout_gravity="center" android:indeterminateTint="@color/gold"/>
    </FrameLayout>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/primary" android:padding="8dp" android:gravity="center"
        android:orientation="horizontal">
        <ImageView android:id="@+id/btnNext" android:layout_width="48dp" android:layout_height="48dp"
            android:src="@android:drawable/ic_media_previous" android:padding="12dp"
            android:background="?selectableItemBackgroundBorderless"/>
        <Spinner android:id="@+id/reciterSpinner" android:layout_width="0dp" android:layout_height="40dp"
            android:layout_weight="1" android:layout_marginStart="8dp" android:layout_marginEnd="4dp"
            android:background="@drawable/spinner_bg" android:popupBackground="@color/bg_card"/>
        <ImageView android:id="@+id/btnPlay" android:layout_width="48dp" android:layout_height="48dp"
            android:src="@android:drawable/ic_media_play" android:padding="8dp" android:background="@drawable/circle_gold"/>
        <ImageView android:id="@+id/btnTafsir" android:layout_width="48dp" android:layout_height="48dp"
            android:src="@android:drawable/ic_menu_info_details" android:padding="12dp"
            android:layout_marginStart="4dp" android:background="?selectableItemBackgroundBorderless"/>
        <ImageView android:id="@+id/btnPrev" android:layout_width="48dp" android:layout_height="48dp"
            android:src="@android:drawable/ic_media_next" android:padding="12dp"
            android:background="?selectableItemBackgroundBorderless"/>
    </LinearLayout>
</LinearLayout>
READERLAYOUT

# ========== fragment_prayer.xml ==========
cat > $PROJECT/app/src/main/res/layout/fragment_prayer.xml << 'PRAYERLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_dark">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="vertical" android:padding="20dp" android:gravity="center">
        <ImageView android:layout_width="80dp" android:layout_height="80dp"
            android:src="@drawable/app_logo" android:layout_marginTop="16dp"/>
        <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:text="🕌 أوقات الصلاة" android:textColor="@color/gold" android:textSize="24sp"
            android:textStyle="bold" android:layout_marginTop="12dp"/>
        <TextView android:id="@+id/cityName" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/text_secondary" android:textSize="14sp" android:layout_marginTop="4dp"/>
        <TextView android:id="@+id/hijriDate" android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:textColor="@color/accent_light" android:textSize="13sp" android:layout_marginTop="4dp"/>
        <ProgressBar android:id="@+id/prayerLoading" android:layout_width="48dp" android:layout_height="48dp"
            android:layout_marginTop="24dp" android:indeterminateTint="@color/gold"/>
        <LinearLayout android:id="@+id/prayerContainer" android:layout_width="match_parent"
            android:layout_height="wrap_content" android:orientation="vertical"
            android:layout_marginTop="16dp" android:visibility="gone"/>
    </LinearLayout>
</ScrollView>
PRAYERLAYOUT

# ========== fragment_qibla.xml ==========
cat > $PROJECT/app/src/main/res/layout/fragment_qibla.xml << 'QIBLALAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:background="@color/bg_dark" android:padding="24dp">
    <ImageView android:layout_width="80dp" android:layout_height="80dp" android:src="@drawable/app_logo"/>
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="🧭 اتجاه القبلة" android:textColor="@color/gold" android:textSize="26sp"
        android:textStyle="bold" android:layout_marginTop="16dp"/>
    <FrameLayout android:layout_width="260dp" android:layout_height="260dp" android:layout_marginTop="32dp">
        <View android:id="@+id/compassView" android:layout_width="260dp" android:layout_height="260dp"/>
        <TextView android:id="@+id/qiblaDirection" android:layout_width="match_parent" android:layout_height="match_parent"
            android:gravity="center" android:textColor="@color/gold" android:textSize="48sp"
            android:textStyle="bold" android:text="🕋"/>
    </FrameLayout>
    <TextView android:id="@+id/qiblaDegrees" android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textColor="@color/text_secondary" android:textSize="18sp" android:layout_marginTop="16dp"/>
</LinearLayout>
QIBLALAYOUT

# ========== fragment_bookmarks.xml ==========
cat > $PROJECT/app/src/main/res/layout/fragment_bookmarks.xml << 'BOOKMARKSLAYOUT'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:background="@color/bg_dark">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:background="@color/primary" android:padding="16dp" android:gravity="center">
        <ImageView android:layout_width="28dp" android:layout_height="28dp"
            android:src="@drawable/app_logo" android:layout_marginEnd="8dp"/>
        <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:text="📌 المحفوظات" android:textColor="@color/gold" android:textSize="22sp" android:textStyle="bold"/>
    </LinearLayout>
    <TextView android:id="@+id/emptyBookmarks" android:layout_width="match_parent" android:layout_height="match_parent"
        android:text="لا توجد صفحات محفوظة\nاضغط ☆ في صفحة القرآن للحفظ" android:textColor="@color/text_secondary"
        android:textSize="16sp" android:gravity="center" android:visibility="gone"/>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/bookmarksRecycler"
        android:layout_width="match_parent" android:layout_height="match_parent" android:padding="8dp"/>
</LinearLayout>
BOOKMARKSLAYOUT

# ========== Drawable resources ==========
cat > $PROJECT/app/src/main/res/drawable/search_bg.xml << 'SEARCHBG'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="#1A3D5C"/><corners android:radius="24dp"/>
    <stroke android:width="1dp" android:color="#132D54"/>
</shape>
SEARCHBG

cat > $PROJECT/app/src/main/res/drawable/circle_gold.xml << 'CIRCLEGOLD'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval">
    <solid android:color="@color/gold"/>
</shape>
CIRCLEGOLD

cat > $PROJECT/app/src/main/res/drawable/badge_bg.xml << 'BADGEBG'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="#1A3D5C"/><corners android:radius="10dp"/>
</shape>
BADGEBG

cat > $PROJECT/app/src/main/res/drawable/spinner_bg.xml << 'SPINNERBG'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="#1A3D5C"/><corners android:radius="8dp"/>
    <stroke android:width="1dp" android:color="@color/gold"/>
    <padding android:left="12dp" android:right="12dp"/>
</shape>
SPINNERBG

cat > $PROJECT/app/src/main/res/drawable/prayer_card_bg.xml << 'PRAYERCARD'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@color/bg_card"/><corners android:radius="16dp"/>
    <stroke android:width="1dp" android:color="@color/divider"/>
</shape>
PRAYERCARD

# ========== SplashActivity.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/SplashActivity.kt << 'SPLASHKT'
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
SPLASHKT

# ========== MainActivity.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/MainActivity.kt << 'MAINKT'
package tech.meshari.quran

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.google.android.material.bottomnavigation.BottomNavigationView
import tech.meshari.quran.ui.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val bottomNav = findViewById<BottomNavigationView>(R.id.bottomNav)
        loadFragment(SurahListFragment())
        bottomNav.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.nav_quran -> loadFragment(SurahListFragment())
                R.id.nav_prayer -> loadFragment(PrayerFragment())
                R.id.nav_qibla -> loadFragment(QiblaFragment())
                R.id.nav_bookmarks -> loadFragment(BookmarksFragment())
                R.id.nav_more -> loadFragment(MoreFragment())
            }
            true
        }
    }
    fun loadFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, fragment).commit()
    }
    fun openReader(surahNumber: Int, page: Int) {
        val fragment = ReaderFragment.newInstance(surahNumber, page)
        supportFragmentManager.beginTransaction().replace(R.id.fragmentContainer, fragment).addToBackStack(null).commit()
    }
}
MAINKT

# ========== Data classes ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/data/Models.kt << 'MODELS'
package tech.meshari.quran.data

data class Surah(val n: Int, val name: String, val ename: String, val ayas: Int, val type: String, val page: Int)
data class Reciter(val id: String, val name: String, val server: String)
data class PrayerTimes(val fajr: String, val sunrise: String, val dhuhr: String, val asr: String, val maghrib: String, val isha: String)
MODELS

cat > $PROJECT/app/src/main/java/$PKG_PATH/data/QuranData.kt << 'QURANDATA'
package tech.meshari.quran.data

object QuranData {
    val surahs = listOf(
        Surah(1,"الفاتحة","Al-Faatiha",7,"Meccan",1),Surah(2,"البقرة","Al-Baqara",286,"Medinan",2),
        Surah(3,"آل عمران","Aal-i-Imraan",200,"Medinan",50),Surah(4,"النساء","An-Nisaa",176,"Medinan",77),
        Surah(5,"المائدة","Al-Maaida",120,"Medinan",106),Surah(6,"الأنعام","Al-An'aam",165,"Meccan",128),
        Surah(7,"الأعراف","Al-A'raaf",206,"Meccan",151),Surah(8,"الأنفال","Al-Anfaal",75,"Medinan",177),
        Surah(9,"التوبة","At-Tawba",129,"Medinan",187),Surah(10,"يونس","Yunus",109,"Meccan",208),
        Surah(11,"هود","Hud",123,"Meccan",221),Surah(12,"يوسف","Yusuf",111,"Meccan",235),
        Surah(13,"الرعد","Ar-Ra'd",43,"Medinan",249),Surah(14,"ابراهيم","Ibrahim",52,"Meccan",255),
        Surah(15,"الحجر","Al-Hijr",99,"Meccan",262),Surah(16,"النحل","An-Nahl",128,"Meccan",267),
        Surah(17,"الإسراء","Al-Israa",111,"Meccan",282),Surah(18,"الكهف","Al-Kahf",110,"Meccan",293),
        Surah(19,"مريم","Maryam",98,"Meccan",305),Surah(20,"طه","Taa-Haa",135,"Meccan",312),
        Surah(21,"الأنبياء","Al-Anbiyaa",112,"Meccan",322),Surah(22,"الحج","Al-Hajj",78,"Medinan",332),
        Surah(23,"المؤمنون","Al-Muminoon",118,"Meccan",342),Surah(24,"النور","An-Noor",64,"Medinan",350),
        Surah(25,"الفرقان","Al-Furqaan",77,"Meccan",359),Surah(26,"الشعراء","Ash-Shu'araa",227,"Meccan",367),
        Surah(27,"النمل","An-Naml",93,"Meccan",377),Surah(28,"القصص","Al-Qasas",88,"Meccan",385),
        Surah(29,"العنكبوت","Al-Ankaboot",69,"Meccan",396),Surah(30,"الروم","Ar-Room",60,"Meccan",404),
        Surah(31,"لقمان","Luqman",34,"Meccan",411),Surah(32,"السجدة","As-Sajda",30,"Meccan",415),
        Surah(33,"الأحزاب","Al-Ahzaab",73,"Medinan",418),Surah(34,"سبإ","Saba",54,"Meccan",428),
        Surah(35,"فاطر","Faatir",45,"Meccan",434),Surah(36,"يس","Yaseen",83,"Meccan",440),
        Surah(37,"الصافات","As-Saaffaat",182,"Meccan",446),Surah(38,"ص","Saad",88,"Meccan",453),
        Surah(39,"الزمر","Az-Zumar",75,"Meccan",458),Surah(40,"غافر","Al-Ghaafir",85,"Meccan",467),
        Surah(41,"فصلت","Fussilat",54,"Meccan",477),Surah(42,"الشورى","Ash-Shura",53,"Meccan",483),
        Surah(43,"الزخرف","Az-Zukhruf",89,"Meccan",489),Surah(44,"الدخان","Ad-Dukhaan",59,"Meccan",496),
        Surah(45,"الجاثية","Al-Jaathiya",37,"Meccan",499),Surah(46,"الأحقاف","Al-Ahqaf",35,"Meccan",502),
        Surah(47,"محمد","Muhammad",38,"Medinan",507),Surah(48,"الفتح","Al-Fath",29,"Medinan",511),
        Surah(49,"الحجرات","Al-Hujuraat",18,"Medinan",515),Surah(50,"ق","Qaaf",45,"Meccan",518),
        Surah(51,"الذاريات","Adh-Dhaariyat",60,"Meccan",520),Surah(52,"الطور","At-Tur",49,"Meccan",523),
        Surah(53,"النجم","An-Najm",62,"Meccan",526),Surah(54,"القمر","Al-Qamar",55,"Meccan",528),
        Surah(55,"الرحمن","Ar-Rahmaan",78,"Medinan",531),Surah(56,"الواقعة","Al-Waaqia",96,"Meccan",534),
        Surah(57,"الحديد","Al-Hadid",29,"Medinan",537),Surah(58,"المجادلة","Al-Mujaadila",22,"Medinan",542),
        Surah(59,"الحشر","Al-Hashr",24,"Medinan",545),Surah(60,"الممتحنة","Al-Mumtahana",13,"Medinan",549),
        Surah(61,"الصف","As-Saff",14,"Medinan",551),Surah(62,"الجمعة","Al-Jumu'a",11,"Medinan",553),
        Surah(63,"المنافقون","Al-Munaafiqoon",11,"Medinan",554),Surah(64,"التغابن","At-Taghaabun",18,"Medinan",556),
        Surah(65,"الطلاق","At-Talaaq",12,"Medinan",558),Surah(66,"التحريم","At-Tahrim",12,"Medinan",560),
        Surah(67,"الملك","Al-Mulk",30,"Meccan",562),Surah(68,"القلم","Al-Qalam",52,"Meccan",564),
        Surah(69,"الحاقة","Al-Haaqqa",52,"Meccan",566),Surah(70,"المعارج","Al-Ma'aarij",44,"Meccan",568),
        Surah(71,"نوح","Nooh",28,"Meccan",570),Surah(72,"الجن","Al-Jinn",28,"Meccan",572),
        Surah(73,"المزمل","Al-Muzzammil",20,"Meccan",574),Surah(74,"المدثر","Al-Muddaththir",56,"Meccan",575),
        Surah(75,"القيامة","Al-Qiyaama",40,"Meccan",577),Surah(76,"الانسان","Al-Insaan",31,"Medinan",578),
        Surah(77,"المرسلات","Al-Mursalaat",50,"Meccan",580),Surah(78,"النبإ","An-Naba",40,"Meccan",582),
        Surah(79,"النازعات","An-Naazi'aat",46,"Meccan",583),Surah(80,"عبس","Abasa",42,"Meccan",585),
        Surah(81,"التكوير","At-Takwir",29,"Meccan",586),Surah(82,"الإنفطار","Al-Infitaar",19,"Meccan",587),
        Surah(83,"المطففين","Al-Mutaffifin",36,"Meccan",587),Surah(84,"الإنشقاق","Al-Inshiqaaq",25,"Meccan",589),
        Surah(85,"البروج","Al-Burooj",22,"Meccan",590),Surah(86,"الطارق","At-Taariq",17,"Meccan",591),
        Surah(87,"الأعلى","Al-A'laa",19,"Meccan",591),Surah(88,"الغاشية","Al-Ghaashiya",26,"Meccan",592),
        Surah(89,"الفجر","Al-Fajr",30,"Meccan",593),Surah(90,"البلد","Al-Balad",20,"Meccan",594),
        Surah(91,"الشمس","Ash-Shams",15,"Meccan",595),Surah(92,"الليل","Al-Lail",21,"Meccan",595),
        Surah(93,"الضحى","Ad-Dhuhaa",11,"Meccan",596),Surah(94,"الشرح","Ash-Sharh",8,"Meccan",596),
        Surah(95,"التين","At-Tin",8,"Meccan",597),Surah(96,"العلق","Al-Alaq",19,"Meccan",597),
        Surah(97,"القدر","Al-Qadr",5,"Meccan",598),Surah(98,"البينة","Al-Bayyina",8,"Medinan",598),
        Surah(99,"الزلزلة","Az-Zalzala",8,"Medinan",599),Surah(100,"العاديات","Al-Aadiyaat",11,"Meccan",599),
        Surah(101,"القارعة","Al-Qaari'a",11,"Meccan",600),Surah(102,"التكاثر","At-Takaathur",8,"Meccan",600),
        Surah(103,"العصر","Al-Asr",3,"Meccan",601),Surah(104,"الهمزة","Al-Humaza",9,"Meccan",601),
        Surah(105,"الفيل","Al-Fil",5,"Meccan",601),Surah(106,"قريش","Quraish",4,"Meccan",602),
        Surah(107,"الماعون","Al-Maa'un",7,"Meccan",602),Surah(108,"الكوثر","Al-Kawthar",3,"Meccan",602),
        Surah(109,"الكافرون","Al-Kaafiroon",6,"Meccan",603),Surah(110,"النصر","An-Nasr",3,"Medinan",603),
        Surah(111,"المسد","Al-Masad",5,"Meccan",603),Surah(112,"الإخلاص","Al-Ikhlaas",4,"Meccan",604),
        Surah(113,"الفلق","Al-Falaq",5,"Meccan",604),Surah(114,"الناس","An-Naas",6,"Meccan",604)
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
QURANDATA

# ========== SurahListFragment.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/SurahListFragment.kt << 'SURAHLISTFRAG'
package tech.meshari.quran.ui

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.button.MaterialButton
import tech.meshari.quran.MainActivity
import tech.meshari.quran.R
import tech.meshari.quran.data.QuranData
import tech.meshari.quran.data.Surah

class SurahListFragment : Fragment() {
    private var currentFilter = "all"
    private var searchQuery = ""
    private lateinit var adapter: SurahAdapter
    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_surah_list, c, false)
        val recycler = view.findViewById<RecyclerView>(R.id.surahRecycler)
        val search = view.findViewById<EditText>(R.id.searchEdit)
        val btnAll = view.findViewById<MaterialButton>(R.id.btnAll)
        val btnMeccan = view.findViewById<MaterialButton>(R.id.btnMeccan)
        val btnMedinan = view.findViewById<MaterialButton>(R.id.btnMedinan)
        adapter = SurahAdapter { surah -> (activity as? MainActivity)?.openReader(surah.n, surah.page) }
        recycler.layoutManager = GridLayoutManager(requireContext(), 2)
        recycler.adapter = adapter
        updateList()
        search.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
            override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) {}
            override fun afterTextChanged(s: Editable?) { searchQuery = s.toString(); updateList() }
        })
        btnAll.setOnClickListener { currentFilter = "all"; updateButtons(btnAll, btnMeccan, btnMedinan); updateList() }
        btnMeccan.setOnClickListener { currentFilter = "Meccan"; updateButtons(btnMeccan, btnAll, btnMedinan); updateList() }
        btnMedinan.setOnClickListener { currentFilter = "Medinan"; updateButtons(btnMedinan, btnAll, btnMeccan); updateList() }
        return view
    }
    private fun updateButtons(active: MaterialButton, vararg others: MaterialButton) {
        active.setBackgroundColor(resources.getColor(R.color.gold, null))
        others.forEach { it.setBackgroundColor(resources.getColor(R.color.bg_card, null)) }
    }
    private fun updateList() {
        var list = QuranData.surahs
        if (currentFilter != "all") list = list.filter { it.type == currentFilter }
        if (searchQuery.isNotEmpty()) list = list.filter { it.name.contains(searchQuery) || it.ename.contains(searchQuery, true) || it.n.toString() == searchQuery }
        adapter.submitList(list)
    }
}
SURAHLISTFRAG

# ========== SurahAdapter.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/SurahAdapter.kt << 'SURAHADAPTER'
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
        holder.number.text = s.n.toString()
        holder.nameAr.text = s.name
        holder.nameEn.text = s.ename
        holder.type.text = if (s.type == "Meccan") "مكية" else "مدنية"
        holder.ayahs.text = "${s.ayas} آية"
        holder.itemView.setOnClickListener { onClick(s) }
    }
}
SURAHADAPTER

# ========== ReaderFragment.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/ReaderFragment.kt << 'READERFRAG'
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
        val view = inflater.inflate(R.layout.fragment_reader, c, false)
        currentPage = arguments?.getInt("page", 1) ?: 1
        val pageImage = view.findViewById<ImageView>(R.id.quranPageImage)
        val pageLoading = view.findViewById<ProgressBar>(R.id.pageLoading)
        val title = view.findViewById<TextView>(R.id.surahTitle)
        val pageInfo = view.findViewById<TextView>(R.id.pageInfo)
        val btnPrev = view.findViewById<ImageView>(R.id.btnPrev)
        val btnNext = view.findViewById<ImageView>(R.id.btnNext)
        val btnPlay = view.findViewById<ImageView>(R.id.btnPlay)
        val btnBack = view.findViewById<ImageView>(R.id.btnBack)
        val spinner = view.findViewById<Spinner>(R.id.reciterSpinner)
        val reciterNames = QuranData.reciters.map { it.name }
        spinner.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, reciterNames)
        spinner.setSelection(0)
        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(p: AdapterView<*>?, v: View?, pos: Int, id: Long) { selectedReciterIndex = pos }
            override fun onNothingSelected(p: AdapterView<*>?) {}
        }
        fun loadPage() {
            val surah = QuranData.getSurahByPage(currentPage)
            title.text = "سورة ${surah.name}"
            pageInfo.text = "$currentPage / 604"
            pageLoading.visibility = View.VISIBLE
            Glide.with(this).load(QuranData.getPageImageUrl(currentPage))
                .into(object : com.bumptech.glide.request.target.CustomTarget<android.graphics.drawable.Drawable>() {
                    override fun onResourceReady(r: android.graphics.drawable.Drawable, t: com.bumptech.glide.request.transition.Transition<in android.graphics.drawable.Drawable>?) { pageImage.setImageDrawable(r); pageLoading.visibility = View.GONE }
                    override fun onLoadCleared(p: android.graphics.drawable.Drawable?) {}
                    override fun onLoadFailed(e: android.graphics.drawable.Drawable?) { pageLoading.visibility = View.GONE }
                })
        }
        loadPage()
        btnPrev.setOnClickListener { if (currentPage > 1) { currentPage--; loadPage() } }
        btnNext.setOnClickListener { if (currentPage < 604) { currentPage++; loadPage() } }
        btnBack.setOnClickListener { parentFragmentManager.popBackStack() }
        btnPlay.setOnClickListener {
            if (isPlaying) { mediaPlayer?.stop(); mediaPlayer?.release(); mediaPlayer = null; isPlaying = false; btnPlay.setImageResource(android.R.drawable.ic_media_play) }
            else {
                val surah = QuranData.getSurahByPage(currentPage)
                val reciter = QuranData.reciters[selectedReciterIndex]
                val url = QuranData.getAudioUrl(reciter, surah.n)
                val mp = MediaPlayer()
                mp.setDataSource(url)
                mp.setOnPreparedListener { mp.start(); this@ReaderFragment.isPlaying = true; btnPlay.setImageResource(android.R.drawable.ic_media_pause) }
                mp.setOnCompletionListener { this@ReaderFragment.isPlaying = false; btnPlay.setImageResource(android.R.drawable.ic_media_play) }
                mp.setOnErrorListener { _, _, _ -> this@ReaderFragment.isPlaying = false; btnPlay.setImageResource(android.R.drawable.ic_media_play); true }
                mp.prepareAsync(); mediaPlayer = mp
            }
        }
        view.findViewById<ImageView>(R.id.btnTafsir).setOnClickListener {
            val surah = QuranData.getSurahByPage(currentPage)
            val dialog = com.google.android.material.bottomsheet.BottomSheetDialog(requireContext())
            val tv = TextView(requireContext()).apply { text = "جاري تحميل تفسير سورة ${surah.name}..."; textSize = 16f; setPadding(32,32,32,32); setTextColor(resources.getColor(R.color.text_primary, null)) }
            dialog.setContentView(tv); dialog.show()
            Thread {
                try {
                    val url = java.net.URL("https://api.alquran.cloud/v1/surah/${surah.n}/ar.muyassar")
                    val conn = url.openConnection() as java.net.HttpURLConnection
                    val json = conn.inputStream.bufferedReader().readText()
                    val obj = com.google.gson.JsonParser.parseString(json).asJsonObject
                    val ayahs = obj.getAsJsonObject("data").getAsJsonArray("ayahs")
                    val sb = StringBuilder()
                    for (i in 0 until ayahs.size()) { val a = ayahs[i].asJsonObject; sb.append("\u064F${a.get("numberInSurah").asInt}\u064E ${a.get("text").asString}\n\n") }
                    activity?.runOnUiThread { tv.text = sb.toString() }
                } catch (e: Exception) { activity?.runOnUiThread { tv.text = "خطأ في تحميل التفسير" } }
            }.start()
        }
        return view
    }
    override fun onDestroyView() { super.onDestroyView(); mediaPlayer?.release(); mediaPlayer = null }
}
READERFRAG

# ========== PrayerFragment.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/PrayerFragment.kt << 'PRAYERFRAG'
package tech.meshari.quran.ui

import android.Manifest
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import tech.meshari.quran.R
import com.google.gson.JsonParser

class PrayerFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, c: ViewGroup?, s: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_prayer, c, false)
        val loading = view.findViewById<ProgressBar>(R.id.prayerLoading)
        val container = view.findViewById<LinearLayout>(R.id.prayerContainer)
        val cityName = view.findViewById<TextView>(R.id.cityName)
        val hijriDate = view.findViewById<TextView>(R.id.hijriDate)
        fun loadPrayer(lat: Double, lon: Double) {
            Thread {
                try {
                    val url = java.net.URL("https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$lon&method=4")
                    val json = url.openConnection().getInputStream().bufferedReader().readText()
                    val data = JsonParser.parseString(json).asJsonObject.getAsJsonObject("data")
                    val timings = data.getAsJsonObject("timings")
                    val date = data.getAsJsonObject("date")
                    val hijri = date.getAsJsonObject("hijri")
                    val prayers = listOf(
                        "🌙" to "الفجر" to timings.get("Fajr").asString,
                        "🌅" to "الشروق" to timings.get("Sunrise").asString,
                        "☀️" to "الظهر" to timings.get("Dhuhr").asString,
                        "🌤" to "العصر" to timings.get("Asr").asString,
                        "🌇" to "المغرب" to timings.get("Maghrib").asString,
                        "🌙" to "العشاء" to timings.get("Isha").asString
                    )
                    activity?.runOnUiThread {
                        loading.visibility = View.GONE; container.visibility = View.VISIBLE
                        cityName.text = "📍 موقعك الحالي"
                        hijriDate.text = "${hijri.get("day").asString} ${hijri.getAsJsonObject("month").get("ar").asString} ${hijri.get("year").asString} هـ"
                        container.removeAllViews()
                        prayers.forEach { (iconName, time) ->
                            val (icon, name) = iconName
                            val card = LinearLayout(requireContext()).apply {
                                orientation = LinearLayout.HORIZONTAL; setPadding(24,20,24,20)
                                background = resources.getDrawable(R.drawable.prayer_card_bg, null)
                                val lp = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT); lp.bottomMargin = 12; layoutParams = lp
                            }
                            val iconTv = TextView(requireContext()).apply { text = icon; textSize = 24f }
                            val nameTv = TextView(requireContext()).apply { text = name; textSize = 18f; setTextColor(resources.getColor(R.color.text_primary, null)); setPadding(16,0,0,0); layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f) }
                            val timeTv = TextView(requireContext()).apply { text = time; textSize = 20f; setTypeface(null, android.graphics.Typeface.BOLD); setTextColor(resources.getColor(R.color.gold, null)) }
                            card.addView(iconTv); card.addView(nameTv); card.addView(timeTv); container.addView(card)
                        }
                    }
                } catch (e: Exception) { activity?.runOnUiThread { loading.visibility = View.GONE; cityName.text = "خطأ في تحميل أوقات الصلاة" } }
            }.start()
        }
        if (ActivityCompat.checkSelfPermission(requireContext(), Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            val lm = requireContext().getSystemService(android.content.Context.LOCATION_SERVICE) as LocationManager
            val loc = lm.getLastKnownLocation(LocationManager.NETWORK_PROVIDER) ?: lm.getLastKnownLocation(LocationManager.GPS_PROVIDER)
            if (loc != null) loadPrayer(loc.latitude, loc.longitude) else loadPrayer(24.7136, 46.6753)
        } else { requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 100); loadPrayer(24.7136, 46.6753) }
        return view
    }
}
PRAYERFRAG

# ========== QiblaFragment.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/QiblaFragment.kt << 'QIBLAFRAG'
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
QIBLAFRAG

# ========== BookmarksFragment.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/BookmarksFragment.kt << 'BOOKMARKSFRAG'
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
                    val tv = TextView(parent.context).apply { textSize = 18f; setPadding(24,20,24,20); setTextColor(resources.getColor(R.color.text_primary, null)); setBackgroundResource(R.drawable.prayer_card_bg)
                        val lp = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT); lp.bottomMargin = 8; layoutParams = lp }
                    return object : RecyclerView.ViewHolder(tv) {}
                }
                override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
                    val page = bookmarks[position]; val surah = QuranData.getSurahByPage(page)
                    (holder.itemView as TextView).text = "📖 صفحة $page - سورة ${surah.name}"
                    holder.itemView.setOnClickListener { (activity as? MainActivity)?.openReader(surah.n, page) }
                }
            }
        }
        return view
    }
}
BOOKMARKSFRAG

# ========== MoreFragment.kt (NEW) ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/MoreFragment.kt << 'MOREFRAG'
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
        val sv = ScrollView(requireContext()).apply { setBackgroundColor(Color.parseColor("#0A1929")) }
        val ll = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.VERTICAL; setPadding(32, 40, 32, 40)
        }
        ll.addView(ImageView(requireContext()).apply {
            setImageResource(R.drawable.app_logo)
            layoutParams = LinearLayout.LayoutParams(200, 200).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 16 }
        })
        ll.addView(TextView(requireContext()).apply {
            text = "المزيد"; setTextColor(Color.parseColor("#D4A847")); textSize = 26f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 32)
        })
        fun makeCard(icon: String, title: String, subtitle: String, onClick: () -> Unit): View {
            val card = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.HORIZONTAL; setPadding(32, 28, 32, 28)
                setBackgroundColor(Color.parseColor("#132F4C"))
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 16 }
                setOnClickListener { onClick() }
            }
            val iconTv = TextView(requireContext()).apply { text = icon; textSize = 36f; setPadding(0, 0, 24, 0) }
            val textContainer = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.VERTICAL
                layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
            }
            textContainer.addView(TextView(requireContext()).apply { text = title; setTextColor(Color.WHITE); textSize = 20f; setTypeface(null, Typeface.BOLD) })
            textContainer.addView(TextView(requireContext()).apply { text = subtitle; setTextColor(Color.parseColor("#B0BEC5")); textSize = 14f; setPadding(0, 4, 0, 0) })
            val arrow = TextView(requireContext()).apply { text = "◀"; setTextColor(Color.parseColor("#D4A847")); textSize = 20f }
            card.addView(iconTv); card.addView(textContainer); card.addView(arrow)
            return card
        }
        ll.addView(makeCard("📜", "فتاوى إسلامية", "أحكام وفتاوى شرعية من مصادر موثوقة") {
            (activity as? MainActivity)?.loadFragment(FatwaFragment())
        })
        ll.addView(makeCard("🧮", "حاسبة الزكاة", "احسب زكاة المال والذهب والفضة") {
            (activity as? MainActivity)?.loadFragment(ZakatFragment())
        })
        ll.addView(makeCard("ℹ️", "حول التطبيق", "معلومات عن التطبيق والمطور") {
            startActivity(Intent(requireContext(), AboutActivity::class.java))
        })
        sv.addView(ll)
        return sv
    }
}
MOREFRAG

# ========== FatwaFragment.kt (NEW) ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/FatwaFragment.kt << 'FATWAFRAG'
package tech.meshari.quran.ui

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
import android.widget.Toast
import androidx.fragment.app.Fragment
import tech.meshari.quran.R

class FatwaFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val sv = ScrollView(requireContext()).apply { setBackgroundColor(Color.parseColor("#0A1929")) }
        val ll = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.VERTICAL; setPadding(32, 40, 32, 40)
        }
        ll.addView(ImageView(requireContext()).apply {
            setImageResource(R.drawable.app_logo)
            layoutParams = LinearLayout.LayoutParams(160, 160).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 16 }
        })
        ll.addView(TextView(requireContext()).apply {
            text = "📜 فتاوى إسلامية"; setTextColor(Color.parseColor("#D4A847")); textSize = 24f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 8)
        })
        ll.addView(TextView(requireContext()).apply {
            text = "أحكام وفتاوى شرعية من مصادر موثوقة"; setTextColor(Color.parseColor("#B0BEC5")); textSize = 14f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 32)
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
                orientation = LinearLayout.HORIZONTAL; setPadding(28, 24, 28, 24)
                setBackgroundColor(Color.parseColor("#132F4C"))
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 12 }
                setOnClickListener { Toast.makeText(requireContext(), "قريباً - $title", Toast.LENGTH_SHORT).show() }
            }
            val iconTv = TextView(requireContext()).apply { text = icon; textSize = 32f; setPadding(0, 0, 20, 0) }
            val textCont = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.VERTICAL
                layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
            }
            textCont.addView(TextView(requireContext()).apply { text = title; setTextColor(Color.WHITE); textSize = 18f; setTypeface(null, Typeface.BOLD) })
            textCont.addView(TextView(requireContext()).apply { text = desc; setTextColor(Color.parseColor("#B0BEC5")); textSize = 13f; setPadding(0, 4, 0, 0) })
            val arrow = TextView(requireContext()).apply { text = "◀"; setTextColor(Color.parseColor("#D4A847")); textSize = 18f }
            card.addView(iconTv); card.addView(textCont); card.addView(arrow)
            ll.addView(card)
        }
        sv.addView(ll)
        return sv
    }
}
FATWAFRAG

# ========== ZakatFragment.kt (NEW) ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/ui/ZakatFragment.kt << 'ZAKATFRAG'
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
        val sv = ScrollView(requireContext()).apply { setBackgroundColor(Color.parseColor("#0A1929")) }
        val ll = LinearLayout(requireContext()).apply { orientation = LinearLayout.VERTICAL; setPadding(32, 40, 32, 40) }

        ll.addView(ImageView(requireContext()).apply {
            setImageResource(R.drawable.app_logo)
            layoutParams = LinearLayout.LayoutParams(160, 160).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 16 }
        })
        ll.addView(TextView(requireContext()).apply {
            text = "🧮 حاسبة الزكاة"; setTextColor(Color.parseColor("#D4A847")); textSize = 24f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 8)
        })
        ll.addView(TextView(requireContext()).apply {
            text = "احسب زكاة أموالك بدقة"; setTextColor(Color.parseColor("#B0BEC5")); textSize = 14f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 16)
        })

        priceStatusText = TextView(requireContext()).apply {
            text = "⏳ جاري تحميل أسعار الذهب والفضة..."; setTextColor(Color.parseColor("#FFD700")); textSize = 13f
            gravity = Gravity.CENTER; setPadding(0, 0, 0, 16)
        }
        ll.addView(priceStatusText)

        fun sectionTitle(text: String): TextView {
            return TextView(requireContext()).apply {
                this.text = text; setTextColor(Color.parseColor("#D4A847")); textSize = 18f
                setTypeface(null, Typeface.BOLD); setPadding(0, 24, 0, 12)
            }
        }

        fun makeInput(hint: String): EditText {
            return EditText(requireContext()).apply {
                this.hint = hint; setHintTextColor(Color.parseColor("#607D8B")); setTextColor(Color.WHITE)
                textSize = 16f; setBackgroundColor(Color.parseColor("#132F4C")); setPadding(24, 20, 24, 20)
                inputType = android.text.InputType.TYPE_CLASS_NUMBER or android.text.InputType.TYPE_NUMBER_FLAG_DECIMAL
                layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 12 }
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
                    override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) {}
                    override fun afterTextChanged(s: Editable?) { calculateZakat() }
                })
            }
        }

        ll.addView(sectionTitle("💵 زكاة المال"))
        moneyInput = makeInput("المبلغ بالريال السعودي")
        ll.addView(moneyInput)

        ll.addView(sectionTitle("🥇 زكاة الذهب"))
        goldPriceText = TextView(requireContext()).apply {
            text = "سعر الذهب 24: جاري التحميل..."; setTextColor(Color.parseColor("#FFD700")); textSize = 14f
            setPadding(0, 0, 0, 8)
        }
        ll.addView(goldPriceText)

        goldContainer = LinearLayout(requireContext()).apply { orientation = LinearLayout.VERTICAL }
        ll.addView(goldContainer)
        addGoldEntry()

        val addGoldBtn = Button(requireContext()).apply {
            text = "➕ إضافة ذهب آخر"; setTextColor(Color.WHITE); setBackgroundColor(Color.parseColor("#1A3D6E"))
            textSize = 14f; setPadding(24, 12, 24, 12)
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 16 }
            setOnClickListener { addGoldEntry() }
        }
        ll.addView(addGoldBtn)

        ll.addView(sectionTitle("🥈 زكاة الفضة"))
        silverPriceText = TextView(requireContext()).apply {
            text = "سعر الفضة: جاري التحميل..."; setTextColor(Color.parseColor("#C0C0C0")); textSize = 14f
            setPadding(0, 0, 0, 8)
        }
        ll.addView(silverPriceText)
        silverInput = makeInput("وزن الفضة بالجرام")
        ll.addView(silverInput)

        ll.addView(View(requireContext()).apply {
            setBackgroundColor(Color.parseColor("#1E3A5F"))
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 2).apply { topMargin = 24; bottomMargin = 24 }
        })

        resultText = TextView(requireContext()).apply {
            text = "جاري تحميل الأسعار..."; setTextColor(Color.parseColor("#D4A847")); textSize = 20f
            setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 16, 0, 16)
        }
        ll.addView(resultText)

        ll.addView(TextView(requireContext()).apply {
            text = "\n📌 ملاحظات:\n• نصاب المال: 85 جرام ذهب عيار 24\n• نصاب الفضة: 595 جرام فضة\n• نسبة الزكاة: 2.5%\n• الأسعار محدثة مباشرة من السوق العالمي"
            setTextColor(Color.parseColor("#8899AA")); textSize = 13f; setPadding(0, 24, 0, 0)
        })

        sv.addView(ll)
        fetchPrices()
        return sv
    }

    private fun fetchPrices() {
        Thread {
            try {
                val rateJson = URL("https://api.exchangerate-api.com/v4/latest/USD").readText()
                val sarRate = JSONObject(rateJson).getJSONObject("rates").getDouble("SAR")

                val goldJson = URL("https://api.gold-api.com/price/XAU").readText()
                val goldUsdOz = JSONObject(goldJson).getDouble("price")
                val gp = (goldUsdOz / 31.1035) * sarRate
                goldPrice24 = gp

                val silverJson = URL("https://api.gold-api.com/price/XAG").readText()
                val silverUsdOz = JSONObject(silverJson).getDouble("price")
                val sp = (silverUsdOz / 31.1035) * sarRate
                silverPrice = sp

                activity?.runOnUiThread {
                    goldPriceText?.text = "سعر الذهب 24: " + String.format("%.2f", gp) + " ر.س / جرام"
                    silverPriceText?.text = "سعر الفضة: " + String.format("%.2f", sp) + " ر.س / جرام"
                    priceStatusText?.text = "✅ الأسعار محدثة مباشرة من السوق العالمي"
                    priceStatusText?.setTextColor(Color.parseColor("#4CAF50"))
                    resultText?.text = "أدخل البيانات لحساب الزكاة"
                    calculateZakat()
                }
            } catch (e: Exception) {
                goldPrice24 = 591.0
                silverPrice = 9.3
                activity?.runOnUiThread {
                    goldPriceText?.text = "سعر الذهب 24: " + String.format("%.2f", goldPrice24) + " ر.س (تقريبي)"
                    silverPriceText?.text = "سعر الفضة: " + String.format("%.2f", silverPrice) + " ر.س (تقريبي)"
                    priceStatusText?.text = "⚠️ تعذر تحميل الأسعار - يتم استخدام أسعار تقريبية"
                    priceStatusText?.setTextColor(Color.parseColor("#FF9800"))
                    resultText?.text = "أدخل البيانات لحساب الزكاة"
                    calculateZakat()
                }
            }
        }.start()
    }

    private fun addGoldEntry() {
        val row = LinearLayout(requireContext()).apply {
            orientation = LinearLayout.HORIZONTAL
            layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT).apply { bottomMargin = 8 }
        }
        val input = EditText(requireContext()).apply {
            hint = "الوزن بالجرام"; setHintTextColor(Color.parseColor("#607D8B")); setTextColor(Color.WHITE)
            textSize = 15f; setBackgroundColor(Color.parseColor("#132F4C")); setPadding(20, 16, 20, 16)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER or android.text.InputType.TYPE_NUMBER_FLAG_DECIMAL
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f).apply { marginEnd = 8 }
            addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
                override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) {}
                override fun afterTextChanged(s: Editable?) { calculateZakat() }
            })
        }
        val spinner = Spinner(requireContext()).apply {
            val karats = arrayOf("عيار 24", "عيار 21", "عيار 18")
            adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, karats)
            setBackgroundColor(Color.parseColor("#132F4C"))
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 0.7f)
            onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(p: AdapterView<*>?, v: View?, pos: Int, id: Long) { calculateZakat() }
                override fun onNothingSelected(p: AdapterView<*>?) {}
            }
        }
        row.addView(input); row.addView(spinner)
        goldContainer?.addView(row)
        goldEntries.add(Pair(input, spinner))
    }

    private fun calculateZakat() {
        if (goldPrice24 == 0.0) return
        var totalValue = 0.0
        val money = moneyInput?.text?.toString()?.toDoubleOrNull() ?: 0.0
        totalValue += money
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
            resultText?.setTextColor(Color.parseColor("#FF9800"))
        } else {
            resultText?.text = "أدخل البيانات لحساب الزكاة"
            resultText?.setTextColor(Color.parseColor("#D4A847"))
        }
    }
}
ZAKATFRAG

# ========== AboutActivity.kt ==========
cat > $PROJECT/app/src/main/java/$PKG_PATH/AboutActivity.kt << 'ABOUTKT'
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
import android.graphics.Color
import android.graphics.Typeface
import android.view.Gravity
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT

class AboutActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val sv = ScrollView(this).apply { setBackgroundColor(Color.parseColor("#0a1628")) }
        val ll = LinearLayout(this).apply { orientation = LinearLayout.VERTICAL; gravity = Gravity.CENTER_HORIZONTAL; setPadding(48, 80, 48, 80) }
        val logo = ImageView(this).apply { setImageResource(R.drawable.app_logo); layoutParams = LinearLayout.LayoutParams(300, 300).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 32 } }
        ll.addView(logo)
        ll.addView(TextView(this).apply { text = "القرآن الكريم"; setTextColor(Color.parseColor("#d4af37")); textSize = 28f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 16) })
        ll.addView(TextView(this).apply { text = "❤ صدقة جارية ❤"; setTextColor(Color.parseColor("#e8b923")); textSize = 22f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 16, 0, 24) })
        ll.addView(TextView(this).apply {
            text = "تطبيق القرآن الكريم هو صدقة جارية لوجه الله تعالى.\n\n" +
                "تم تطوير هذا التطبيق بالاعتماد على مصادر معتمدة وموثوقة:\n\n" +
                "• مصحف المدينة النبوية الإلكتروني\n" +
                "• أوقات الصلاة من مصادر فلكية دقيقة\n" +
                "• اتجاه القبلة باستخدام حسابات جغرافية معتمدة\n" +
                "• حاسبة الزكاة بأسعار المعادن المحدثة\n" +
                "• الفتاوى من مصادر شرعية موثوقة\n\n" +
                "نسأل الله أن يجعل هذا العمل خالصاً لوجهه الكريم\nوأن يجعله في ميزان حسنات كل من ساهم فيه."
            setTextColor(Color.WHITE); textSize = 16f; gravity = Gravity.CENTER; setLineSpacing(8f, 1.2f); setPadding(0, 0, 0, 40)
        })
        ll.addView(android.view.View(this).apply { setBackgroundColor(Color.parseColor("#1a3a5c")); layoutParams = LinearLayout.LayoutParams(MATCH_PARENT, 2).apply { bottomMargin = 32; topMargin = 8 } })
        ll.addView(TextView(this).apply { text = "الإصدار: 4.3.0\nتاريخ النشر: مارس 2026"; setTextColor(Color.parseColor("#8899aa")); textSize = 14f; gravity = Gravity.CENTER; setPadding(0, 0, 0, 32) })
        ll.addView(TextView(this).apply { text = "للتواصل مع المطور"; setTextColor(Color.parseColor("#d4af37")); textSize = 18f; setTypeface(null, Typeface.BOLD); gravity = Gravity.CENTER; setPadding(0, 0, 0, 16) })
        ll.addView(Button(this).apply { text = "📱 +966555877723"; setTextColor(Color.WHITE); setBackgroundColor(Color.parseColor("#0A1628")); textSize = 18f; setPadding(48, 24, 48, 24)
            layoutParams = LinearLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 24 }
            setOnClickListener { startActivity(Intent(Intent.ACTION_DIAL, Uri.parse("tel:+966555877723"))) }
        })
        ll.addView(Button(this).apply { text = "💬 واتساب"; setTextColor(Color.WHITE); setBackgroundColor(Color.parseColor("#1A3D6E")); textSize = 18f; setPadding(48, 24, 48, 24)
            layoutParams = LinearLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT).apply { gravity = Gravity.CENTER_HORIZONTAL; bottomMargin = 40 }
            setOnClickListener { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://wa.me/966555877723"))) }
        })
        ll.addView(TextView(this).apply { text = "اللهم اجعل هذا العمل في ميزان حسناتنا يوم القيامة"; setTextColor(Color.parseColor("#d4af37")); textSize = 14f; gravity = Gravity.CENTER; setTypeface(null, Typeface.ITALIC) })
        sv.addView(ll); setContentView(sv)
        supportActionBar?.apply { title = "حول التطبيق"; setDisplayHomeAsUpEnabled(true) }
    }
    override fun onSupportNavigateUp(): Boolean { onBackPressed(); return true }
}
ABOUTKT

# ========== proguard-rules.pro ==========
cat > $PROJECT/app/proguard-rules.pro << 'PROGUARD'
-keep class tech.meshari.quran.data.** { *; }
-keep class com.google.gson.** { *; }
-dontwarn okhttp3.**
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
PROGUARD

# ========== gradle.properties ==========
cat > $PROJECT/gradle.properties << 'GRADLEPROPS'
android.useAndroidX=true
org.gradle.jvmargs=-Xmx2048m
GRADLEPROPS

echo "✅ Quran Android app v4.3.0 created!"
echo "📱 Package: tech.meshari.quran"
echo "🎨 Theme: Blue gradients - NO green"
echo "🆕 New: Fatwa + Zakat (live prices) + More menu"
echo "🚀 Version: 4.3.0 (versionCode 7)"
