import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "ui/BottomBar"
import "ui/Tracks"
import "ui/More"
import "ui/Profile"
import "qrc:/ui"

ApplicationWindow {

    property string appFont: "Roboto"

    //property string dark: "#2D2D2D"
    property string dark: "#1C1B1F"
    property string darkest: "#171717"
    //property string dark: "#2E2A31"
    property string darkTransparency: "#EF1C1B1F"
    property string darkestTransparency: "#EF171717"

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

    //contentOrientation: "PortraitOrientation"

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

    Liked {
        id: rightScreen

        visible: false
    }

    BottomBar {
        id: bottomBar
    }

    TopLogo {
        id: topBar
    }

    MusicPlayer {
        id: musicPlayer
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



