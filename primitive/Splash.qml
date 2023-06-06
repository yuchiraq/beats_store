import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtMultimedia
import QtQuick.Effects

Rectangle {

    id: splashScreen

    anchors.centerIn: parent

    height: parent.height >= parent.width ? parent.height / 3 : parent.width / 3
    width: height

    radius: width / 8

    color: "transparent"

    property bool updateNeed: false
    property bool wait: false

    DropShadow {
        anchors.fill: background
        source: background
        radius: blockMargin / 2
        color: "black"
        opacity: .5
        transparentBorder: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        radius: parent.radius
        color: surface
        opacity: .4
    }

    Image {
        id: imOverlay
        anchors.fill: background
        source: "qrc:/ui_icons/мягкийСвет20.jpg"
        opacity: .03
        visible: false
    }

    OpacityMask {
        source: imOverlay
        maskSource: background
        anchors.fill: maskSource
        opacity: imOverlay.opacity
    }

    Image {
        id: fullLogoSplash
        source: "qrc:/topLogoCQ.png"

        //anchors.centerIn: parent
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: parent.radius * 1.5
        }
        height: parent.height / 2
        fillMode: Image.PreserveAspectFit

        opacity: 1

        //        onStatusChanged: if (fullLogoSplash.status === Image.Ready) {
        //                             startSplash()
        //                             textAnim.restart()
        //                         }
    }

    ProgressBar {

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: parent.radius
        }
        width: parent.width - parent.radius * 2
        indeterminate: true
        Material.theme: Material.LightBlue
    }
    Connections {
        target: setHost
    }

    function closeSplash() {
        //        while (!setHost.connectDB()) {
        //            console.log("cikle")
        //        }
        console.log("1cikle")
        if (notification.notificationText != "")
            notification.start()

        startSplashScreen.visible = false
        stackMaskedBackground.visible = false
        stackMaskedBackground.opacity = 1
    }

    function startSplash() {

        console.log("startSPLASH")
        n = 0
        //startSplashScreen.opacity = 1
        //startSplashScreen.visible = true
        if (splashScreen.opacity != 1)
            splashOn.restart()

        if (!setHost.connect()) {
            notification.notificationText = "Нет подключения к серверу"
        } else {
            updated = true
            notification.notificationText = setHost.checkNotification()
            centralScreen.update()
        }

        bottomBar.bottomBarCorrector()

        if (splashOn.running)
            splashScreen.wait = true
        else
            splashOff.restart()
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

    ParallelAnimation {
        id: splashOn

        NumberAnimation {
            target: splashScreen
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: 0
            to: parent.height >= parent.width ? parent.height / 3 : parent.width / 3
        }

        NumberAnimation {
            target: splashScreen
            property: "opacity"
            from: 0
            to: 1
            duration: 400
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: stackMaskedBackground
            property: "opacity"
            from: 0
            to: 1
            duration: 400
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            duration: 2000
        }

        onStarted: {
            stackMaskedBackground.visible = true
            splashScreen.visible = true
        }
        onFinished: {
            if (splashScreen.wait)
                splashOff.restart()
        }
    }

    ParallelAnimation {
        id: splashOff

        NumberAnimation {
            target: splashScreen
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: splashScreen.height
            to: 0
        }

        NumberAnimation {
            target: splashScreen
            property: "opacity"
            from: 1
            to: 0
            duration: 400
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: stackMaskedBackground
            property: "opacity"
            from: 1
            to: 0
            duration: 400
            easing.type: Easing.InOutQuad
        }
        onFinished: closeSplash()
        running: false
    }

    NumberAnimation {
        duration: 1000
        onStarted: stackMaskedBackground.visible = true
        onFinished: startSplash()
        running: updateNeed
    }
}
