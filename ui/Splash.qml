import QtQuick 2.15


Rectangle {

    id: splashScreen

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    color: darkest

    property int logoOGwidth: splashScreen.width / 2.5
    property int timeAnimation: 110

    Item {

        height: parent.height / 4
        width: parent.width

        anchors.centerIn: parent

        Image {
            id: fullLogoSplash
            source: "qrc:/png/fullLOGO.png"

            anchors.centerIn: parent

            height: parent.height / 5
            width: height * (2308 / 392)

            opacity: 0

        }

        Image {
            id: logoOG

            source: "qrc:/png/logo.png"

            anchors {
                verticalCenter: parent.verticalCenter
                left: fullLogoSplash.left
            }

            width: logoOGwidth

            height: width

            anchors.leftMargin: fullLogoSplash.width / 2 - width / 2

        }

        SequentialAnimation{
            id: splashAnimation


            NumberAnimation {
                duration: timeAnimation * 2
            }
            NumberAnimation {
                target: logoOG
                property: "width"
                duration: timeAnimation
                from: logoOGwidth; to: fullLogoSplash.width / (2307 / 731)
            }
            NumberAnimation {
                target: logoOG
                property: "anchors.leftMargin"
                duration: timeAnimation
                from: logoOG.marginFirst; to: 0
            }

            NumberAnimation {
                target: fullLogoSplash
                property: "opacity"
                duration: timeAnimation
                from: 0; to: 1
            }

            NumberAnimation {
                target: logoOG
                property: "opacity"
                duration: 0
                from: 1; to: 0
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

            onStarted: bottomBar.bottomBarCorrector()
            onFinished: closeSplash()
            running: true

        }

    }

    function closeSplash(){
        //bottomBar.bottomBarCorrector()
        splashClick.destroy()
        startSplashScreen.destroy()
    }
}
