import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtMultimedia

Rectangle {

    id: splashScreen

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    color: darkest

    property int logoOGwidth: startSplashScreen.width / 2.5
    property int timeAnimation: 110

    Image {
        id: fullLogoSplash
        source: "qrc:/topLogoCQ.png"

        anchors.centerIn: parent

        height: parent.height / 5
        fillMode: Image.PreserveAspectFit

        opacity: 1

        onStatusChanged: if (image.status === Image.Ready) {
                             startSplash()
                             textAnim.restart()
                         }
    }

    ProgressBar {
        id: progress
        anchors {
            //top: fullLogoSplash.bottom
            horizontalCenter: parent.horizontalCenter
            //topMargin: blockMargin * 3
            top: fullLogoSplash.bottom
            bottom: parent.bottom
        }

        indeterminate: true
    }

    Connections {
        target: setHost
    }

    function closeSplash() {
        centralScreen.update()
        //        while (!setHost.connectDB()) {
        //            console.log("cikle")
        //        }
        console.log("1cikle")
        if (notification.notificationText != "")
            notification.start()

        bottomBar.bottomBarCorrector()
        startSplashScreen.visible = false
    }

    function startSplash() {
        console.log("startSPLASH")
        n = 0
        startSplashScreen.opacity = 1
        startSplashScreen.visible = true

        if (!setHost.connect()) {
            notification.notificationText = "Нет подключения к серверу"
        } else {
            updated = true
            notification.notificationText = setHost.checkNotification()
        }

        bottomBar.bottomBarCorrector()
        closeSplash()
    }

    MouseArea {
        anchors.fill: parent

        onClicked: textAnim.restart()
    }

    TextField {
        id: ipField

        color: secondary

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: fullLogoSplash.top
        }

        onAccepted: setHost.getHost(ipField.text)

        visible: false
    }

    Text {
        id: textConnection
        text: "Подключение..."

        font.family: appFont
        font.bold: true

        color: accent

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: fullLogoSplash.bottom
            bottomMargin: 0 - progress.height / 4 * 3
        }

        opacity: 0
    }

    property int n: 0

    SequentialAnimation {
        id: textAnim

        NumberAnimation {
            target: textConnection
            property: "opacity"
            from: 0
            to: 1
            duration: 500
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: textConnection
            property: "opacity"
            from: 1
            to: 0
            duration: 500
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: textConnection
            property: "opacity"
            from: 0
            to: 1
            duration: 500
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: textConnection
            property: "opacity"
            from: 1
            to: 0
            duration: 500
            easing.type: Easing.InOutQuad
        }

        onFinished: {
            ipField.visible = true
            n++
            if (n >= 2)
                closeSplash()
        }
    }

    NumberAnimation {
        duration: 10
        onFinished: startSplash()
        running: true
    }
}
