import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import "ui/BottomBar"
import "ui/Tracks"
import "ui/More"
import "ui/Profile"
import "qrc:/TextStyles"
import "qrc:/ui"

ApplicationWindow {

    property string darkest: "#1f1f1f"
    property string dark: "#292A29"
    property string light: "#CCD7CC"

    id: mainScreen

    width: 1080/2
    height: 1920/2
    visible: true
    title: qsTr("beats")

    contentOrientation: "PortraitOrientation"

    //color: "#282323"
    color: darkest

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

        //color: "#282323"
        color: darkest

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



