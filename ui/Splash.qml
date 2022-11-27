import QtQuick 2.15

Item {
    id: splashScreen

    height: parent.height / 4
    width: parent.width

    anchors.centerIn: parent

    //property int logoOGwidth: splashScreen.width / 38 * 18
    property int logoOGwidth: splashScreen.width / 2.5
    property int timeAnimation: 110

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
            verticalCenter: splashScreen.verticalCenter
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

        function closeSplash(){
            splashClick.destroy()
            startSplashScreen.destroy()
        }

        onFinished: closeSplash()
        running: true

    }



}
