apkBaseName=$1
tempSmaliDir=$2

if [ "$apkBaseName" = "TeleService" ];then
        echo ">>> in custom_app for $apkBaseName to adjust the interface "registerForNetworkLocked" with "registerForPersoLocked""
        find $tempSmaliDir/ -name "*.smali" | xargs sed -i 's#registerForNetworkLocked#registerForPersoLocked#g'  

elif [ "$apkBaseName" = "Keyguard" ];then
        echo ">>> in custom_app for $apkBaseName to adjust the field IccCardConstants$State;->NETWORK_LOCKED with IccCardConstants$State;->PERSO_LOCKED"
        find $tempSmaliDir/ -name "*.smali" | xargs sed -i 's#IccCardConstants$State;->NETWORK_LOCKED#IccCardConstants$State;->PERSO_LOCKED#g'   

elif [ "$apkBaseName" = "SystemUI" ];then
        echo ">>> in custom_app for $apkBaseName to adjust the field IccCardConstants$State;->NETWORK_LOCKED with IccCardConstants$State;->PERSO_LOCKED"
        find $tempSmaliDir/ -name "*.smali" | xargs sed -i 's#IccCardConstants$State;->NETWORK_LOCKED#IccCardConstants$State;->PERSO_LOCKED#g'

elif [ "$apkBaseName" = "MediaProvider" ];then
        echo ">>> in custom_app for $apkBaseName to adjust interface"
	sed -i 's#invoke-static/range {.*}, Landroid/os/FileUtils;->getFatVolumeId(Ljava/lang/String;)I#invoke-direct/range {p0 .. p0}, Lcom/android/providers/media/MediaProvider;->getExternalStorageFatVolumeId()I#g' $tempSmaliDir/smali/com/android/providers/media/MediaProvider.smali

elif [ "$apkBaseName" = "Settings" ];then
        echo ">>> in custom_app for $apkBaseName to disadble select runtime"
	sed -i 's#android:title="@string/select_runtime_title" android:key="select_runtime"#android:title="@string/select_runtime_title" android:selectable="false" android:key="select_runtime"#g' $tempSmaliDir/res/xml/development_prefs.xml

fi
