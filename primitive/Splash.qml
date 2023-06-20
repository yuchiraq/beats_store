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

    //    DropShadow {
    //        anchors.fill: background
    //        source: background
    //        radius: blockMargin / 2
    //        color: "black"
    //        opacity: .5
    //        transparentBorder: true
    //    }
    Rectangle {

        anchors.centerIn: parent
        radius: parent.radius - 2
        color: surface
        opacity: .8

        height: parent.height + 4
        width: height

        SequentialAnimation on radius {
            NumberAnimation {
                duration: 1002
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 24 - 2 : mainScreen.width / 24 - 2
                to: mainScreen.height >= mainScreen.width ? mainScreen.height / 6
                                                            - 2 : mainScreen.width / 6 - 2

                easing.type: Easing.InOutCirc
            }
            NumberAnimation {
                duration: 1002
                to: mainScreen.height >= mainScreen.width ? mainScreen.height / 24
                                                            - 2 : mainScreen.width / 24 - 2
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 6 - 2 : mainScreen.width / 6 - 2
                easing.type: Easing.InOutCirc
            }
            loops: Animation.Infinite
            running: startSplashScreen.visible
        }

        NumberAnimation on rotation {
            duration: 2004
            from: 0
            to: 360
            loops: Animation.Infinite
            easing.type: Easing.InOutCirc
            running: startSplashScreen.visible
        }

        ColorAnimation on color {
            from: surface
            to: alert
            duration: 100
            running: startSplashScreen.visible
        }
    }
    Rectangle {

        anchors.centerIn: parent
        radius: parent.radius - 1
        color: surface
        opacity: .8

        height: parent.height + 2
        width: height

        SequentialAnimation on radius {
            NumberAnimation {
                duration: 1001
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 24 - 1 : mainScreen.width / 24 - 1
                to: mainScreen.height >= mainScreen.width ? mainScreen.height / 6
                                                            - 1 : mainScreen.width / 6 - 1

                easing.type: Easing.InOutCirc
            }
            NumberAnimation {
                duration: 1001
                to: mainScreen.height >= mainScreen.width ? mainScreen.height / 24
                                                            - 1 : mainScreen.width / 24 - 1
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 6 - 1 : mainScreen.width / 6 - 1
                easing.type: Easing.InOutCirc
            }
            loops: Animation.Infinite
            running: startSplashScreen.visible
        }

        NumberAnimation on rotation {
            duration: 2002
            from: 0
            to: 360
            loops: Animation.Infinite
            easing.type: Easing.InOutCirc
            running: startSplashScreen.visible
        }

        ColorAnimation on color {
            from: surface
            to: accent
            duration: 100
            running: startSplashScreen.visible
        }
    }

    Rectangle {
        id: background

        anchors.fill: parent
        radius: parent.radius
        color: surface
        opacity: 1

        SequentialAnimation on radius {
            NumberAnimation {
                duration: 1000
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 24 : mainScreen.width / 24
                to: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                            / 6 : mainScreen.width / 6

                easing.type: Easing.InOutCirc
            }
            NumberAnimation {
                duration: 1000
                to: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                            / 24 : mainScreen.width / 24
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 6 : mainScreen.width / 6
                easing.type: Easing.InOutCirc
            }
            loops: Animation.Infinite
            running: startSplashScreen.visible
        }

        NumberAnimation on rotation {
            duration: 2000
            from: 0
            to: 360
            loops: Animation.Infinite
            easing.type: Easing.InOutCirc
            running: startSplashScreen.visible
        }
    }

    Image {
        id: fullLogoSplash
        source: "qrc:/topLogoCQ.png"

        anchors.centerIn: parent
        //        anchors {
        //            horizontalCenter: parent.horizontalCenter
        //            top: parent.top
        //            topMargin: parent.radius * 1.5
        //        }
        height: mainScreen.height >= mainScreen.width ? mainScreen.height / 6 : mainScreen.width / 6
        fillMode: Image.PreserveAspectFit

        opacity: 1

        //        onStatusChanged: if (fullLogoSplash.status === Image.Ready) {
        //                             startSplash()
        //                             textAnim.restart()
        //                         }
        SequentialAnimation on height {
            NumberAnimation {
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 6 : mainScreen.width / 6
                to: mainScreen.height >= mainScreen.width ? mainScreen.height / 3
                                                            / 2.2 : mainScreen.width / 3 / 2.2
                duration: 1000
                easing.type: Easing.InOutCirc
            }
            NumberAnimation {
                to: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                            / 6 : mainScreen.width / 6
                from: mainScreen.height >= mainScreen.width ? mainScreen.height
                                                              / 3 / 2.2 : mainScreen.width / 3 / 2.2
                duration: 1000
                easing.type: Easing.InOutCirc
            }
            loops: Animation.Infinite
            running: startSplashScreen.visible
        }
    }

    ProgressBar {
        id: progress

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: parent.radius
        }
        width: parent.width - parent.radius * 2
        indeterminate: true
        Material.theme: Material.LightBlue
        visible: false
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

        var textCur = setHost.checkNotification()
        console.log(textCur)

        if (!setHost.connect()) {
            notification.notificationText = "Нет подключения к серверу"
            console.log("setNotify", notification.notificationText)
        } else {
            updated = true
            centralScreen.update()
        }

        if (textCur != "") {
            notification.notificationText = textCur
            console.log("setNotify" + notification.notificationText)
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

        //font.family: appFont
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
        duration: 100
        onStarted: stackMaskedBackground.visible = true
        onFinished: startSplash()
        running: updateNeed
    }
}
