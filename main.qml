import QtQml 2.12
import QtQuick 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.LocalStorage 2.0
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

//for Qt6+
import "ui/BottomBar"
import "ui/Tracks"
import "ui/More"
import "ui/Profile"
import "qrc:/ui"
import "qrc:/fonts"
import "qrc:/ui/Pages"

ApplicationWindow {
    id: mainScreen

    property string appFont: "SF Pro Display"
    LocalFont {
        id: localFont
    }

    //property string dark: "#1C1B1F"
    //property string darkest: "#171717"
    //property string darkTransparency: "#EF1C1B1F"
    //property string darkestTransparency: "#F6171717"

    //property string light: "#CAC4D0"
    //property string outline: "#49454F"

    //property string secondary: "#FFD8E4"
    property string darkVariant: "#4F1C30"
    property string alert: "#E91E63"

    //cols by CQ
    property string dark: "#171517"
    property string darkest: "#111111"
    //property string dark: "#112"
    //property string darkest: "#000"
    property string darkTransparency: "#EF19191A"
    property string darkestTransparency: "#F6111111"

    property string secondary: "#E1E1EC"
    property string light: "#CACACA"
    property string outline: "#2F2F3F"
    property string accent: "#EAEAFE"

    property int blockMargin: mainScreen.width / 40

    property string ip: "172.20.10.7"

    width: 1080 / 2
    height: 1920 / 2
    visible: true
    title: qsTr("beats")

    color: darkest

    // visibility: "FullScreen"
    Keys.onBackPressed: {
        topBar.standartBack()
    }
    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: centralScreen

        Keys.onBackPressed: {
            topBar.standartBack()
        }
    }

    BestTracks {
        id: centralScreen
    }

    ProfileTest {
        id: leftScreen

        visible: false
    }

    Liked {
        id: rightScreen

        visible: false
    }

    AlbumPage {
        id: albumPage
        visible: false
    }

    AuthorPage {
        id: authorPage
        visible: false
    }

    //    DropShadow {
    //        anchors.fill: bottomBar
    //        transparentBorder: true
    //        horizontalOffset: 0
    //        verticalOffset: -4
    //        radius: 8.0
    //        color: "#40000000"
    //        source: bottomBar
    //        visible: musicPlayer.visible ? false : true
    //    }
    BottomBar {
        id: bottomBar
    }

    //    Image {
    //        id: topBarShadow
    //        source: "qrc:/png/interface/shadow.png"
    //        rotation: 180
    //        anchors.top: topBar.bottom
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        width: parent.width
    //        height: width / 1920 * 100
    //        opacity: 0.3
    //    }
    //    DropShadow {
    //        anchors.fill: topBar
    //        transparentBorder: true
    //        horizontalOffset: 0
    //        verticalOffset: 4
    //        radius: 8.0
    //        color: "#40000000"
    //        source: topBar
    //    }
    TopLogo {
        id: topBar
    }

    MusicPlayer {
        id: musicPlayer
    }

    BeatFunctions {
        id: beatFunctions
    }

    StyleChooser {
        id: styleChooser
    }

    Splash {
        id: startSplashScreen
    }
}
