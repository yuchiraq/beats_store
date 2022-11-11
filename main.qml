import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Universal

import "ui/BottomBar"
import "ui/Tracks"
import "ui/More"
import "ui/Profile"
import "qrc:/TextStyles"
import "qrc:/ui"

ApplicationWindow {

    id: mainScreen

    width: 1600
    height: 900
    visible: true
    title: qsTr("beats")

    contentOrientation: "PortraitOrientation"

    color: "#282323"

    StackView {

        id: stackView

        anchors.fill: parent


        initialItem: centralScreen
    }

    BestTracks {
        id: centralScreen

        visible: true

    }

    ProfileTest {
        id: leftScreen

        visible: false

    }

    MoreTest {
        id: rightScreen

        visible: false

    }

    BottomBar {
        id: bottomBar
    }

    TopLogo {
        id: topLogo
    }

    Rectangle {

        id: startSplashScreen

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        color: "#282323"

        Splash{}

    }

    MouseArea {
        id: splashClick
        anchors.fill: parent

        onClicked: {
            startSplashScreen.destroy()
            splashClick.destroy()
        }
    }

}



