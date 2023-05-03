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

    MediaPlayer {
        id: startedSound
        audioOutput: AudioOutput {}
        source: "qrc:/animated/lovelyboot1-103697 (mp3cut.net).mp3"
    }

    Item {

        height: parent.height / 4
        width: parent.width

        anchors.centerIn: parent

        Image {
            id: fullLogoSplash
            source: "qrc:/topLogoCQ.png"

            anchors.centerIn: parent

            height: parent.height / 5
            width: height * (2308 / 392)

            opacity: 0
        }

        Image {
            id: logoOG

            source: "qrc:/topLogoCQ.png"

            anchors {
                verticalCenter: parent.verticalCenter
                left: fullLogoSplash.left
            }

            width: logoOGwidth

            height: width

            anchors.leftMargin: fullLogoSplash.width / 2 - width / 2
        }

        SequentialAnimation {
            id: splashAnimation

            NumberAnimation {}
            NumberAnimation {
                target: logoOG
                property: "width"

                from: logoOG.width
                to: fullLogoSplash.width / (2307 / 731)
            }
            NumberAnimation {
                target: logoOG
                property: "anchors.leftMargin"

                from: logoOG.anchors.leftMargin
                to: 0
            }

            NumberAnimation {
                target: fullLogoSplash
                property: "opacity"

                from: 0
                to: 1
            }

            NumberAnimation {
                target: logoOG
                property: "opacity"

                from: 1
                to: 0
            }

            NumberAnimation {
                duration: timeAnimation * 5
            }

            NumberAnimation {
                target: splashScreen
                property: "opacity"
                duration: timeAnimation * 2
                from: 1
                to: 0
            }

            onStarted: {
                centralScreen.update()
                startedSound.play()
                bottomBar.bottomBarCorrector()
            }
            onFinished: closeSplash()
            running: true
        }
    }

    function splashStoper() {
        while (splashAnim.currentFrame < splashAnim.frameCount) {

        }

        splashAnim.paused = true
    }

    function closeSplash() {

        bottomBar.bottomBarCorrector()
        startSplashScreen.visible = 0
    }

    function startSplash() {
        fullLogoSplash.opacity = 0
        logoOG.width = logoOGwidth
        logoOG.anchors.leftMargin = fullLogoSplash.width / 2 - logoOG.width / 2
        logoOG.opacity = 1
        startSplashScreen.opacity = 1
        startSplashScreen.visible = 1
        splashAnimation.running = true
    }
}
