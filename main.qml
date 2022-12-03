import QtQuick 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects   //for Qt6+

import "ui/BottomBar"
import "ui/Tracks"
import "ui/More"
import "ui/Profile"
import "qrc:/ui"

ApplicationWindow {

    property string appFont: "Montserrat"

    //property string dark: "#2D2D2D"
    property string dark: "#1C1B1F"
    property string darkest: "#171717"
    //property string dark: "#2E2A31"
    property string darkTransparency: "#EF1C1B1F"
    property string darkestTransparency: "#F6171717"

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

    Image {
        id: topBarShadow
        source: "qrc:/png/interface/shadow.png"
        rotation: 180
        anchors.top: topBar.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height: width / 1920 * 100
        opacity: 0.3
    }

    Image {
        id: bottomBarShadow
        source: "qrc:/png/interface/shadow.png"
        anchors.bottom: bottomBar.top
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height: width / 1920 * 100
        opacity: 0.3
    }

    MusicPlayer { id: musicPlayer }

    BeatFunctions { id: beatFunctions }

    Splash {
        id: startSplashScreen
    }

    MouseArea {
        id: splashClick
        anchors.fill: parent

        onClicked: {
            startSplashScreen.closeSplash()
        }
    }

}



