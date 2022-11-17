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

    property string darkest: "#1C1B1F"
    property string dark: "#313033"
    property string light: "#CAC4D0"
    property string outline: "#49454F"
    property string secondary: "#FFD8E4"

    property string darkVariant: "#4F1C30"
    property string alert: "#E91E63"

    property int blockMargin: mainScreen.width / 40

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



