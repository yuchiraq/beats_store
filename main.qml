import QtQml.Models 2.3
import QtQuick 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
//import QtGraphicalEffects 1.15
import QtQuick.Effects

//for Qt6+
import "qrc:/screenTracks"
import "qrc:/screenMore"
import "qrc:/screenProfile"
import "qrc:/pages"
import "qrc:/bottomBar"
import "qrc:/topBar"
import "qrc:/primitive"
import "qrc:/cards"

Window {
    id: mainScreen

    property string appFont: "SF Pro Display"

    FontLoader {
        id: localFont
        source: "qrc:/fonts/SFPRODISPLAYREGULAR.OTF"
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
    property string dark: darkTheme ? "#111" : "#F0EFF4"
    property string darkest: darkTheme ? "#0D0C0D" : "#F1F0EA"

    property string darkTransparency: darkTheme ? "#EF19191A" : ""
    property string darkestTransparency: darkTheme ? "#810F0A0F" : "#81F1F0EA"

    property string secondary: darkTheme ? "#E1E1EC" : "#2D232E"
    property string light: darkTheme ? "#F5EFED" : "#474448"
    property string outline: darkTheme ? "#272838" : "#534B52"

    property string accent: darkTheme ? "#EAEAFE" : "#534B52"
    property string accentTransparency: darkTheme ? "#10EAEAFE" : "#10534B52"

    property bool darkTheme: true

    property int blockMargin: mainScreen.width / 40

    property string ip: "172.20.10.7"

    width: 1080 / 2
    height: 1920 / 2
    visible: true
    title: qsTr("beats")

    color: darkest

    //visibility: "FullScreen"
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

    Rectangle {
        id: blurMask

        width: parent.width
        anchors.bottom: parent.bottom
        height: musicPlayer.visible ? blockMargin * 8 : blockMargin * 5
        color: darkest
        visible: true
    }

    MultiEffect {
        id: stackMasked
        source: stackView
        anchors.fill: blurMask

        autoPaddingEnabled: false

        blurEnabled: true
        blur: 1

        blurMax: 100
        maskEnabled: true
        maskSource: blurMask
        maskSpreadAtMax: 1
        maskSpreadAtMin: 1
    }

    BottomBar {
        id: bottomBar
        color: darkestTransparency
    }

    TopLogo {
        id: topBar
    }

    MusicPlayer {
        id: musicPlayer
    }

    MouseArea {
        anchors.fill: parent
        visible: stackMaskedBackground.visible
    }

    Rectangle {
        id: stackMaskedDarkBackground
        anchors.fill: stackView
        color: darkest
        visible: stackMaskedBackground.visible
    }

    GaussianBlur {
        id: stackMaskedBackground
        source: stackView
        anchors.fill: stackView
        radius: 64
        samples: 128
        transparentBorder: false

        visible: false
    }

    BeatFunctions {
        id: beatFunctions
    }

    StyleChooser {
        id: styleChooser
    }

    Splash {
        id: startSplashScreen
        visible: false
    }

    MouseArea {

        id: oRoot
        anchors.fill: parent

        Timer {
            id: timer
            interval: 100
        }

        signal sgSwipeRight

        QtObject {

            property bool pTracing: false
            property real pXVelocity: 0.0
            property real pYVelocity: 0.0
            property int pXPrev: 0
            property int pYPrev: 0

            id: oPrivate
        }
        onPressed: {
            if (mouseX < blockMargin) {
                console.log("HASIKUGDUSGDAS")
                oPrivate.pXPrev = mouseX
                oPrivate.pXVelocity = 0
            } else
                mouse.accepted = false
        }

        onPositionChanged: {
            var oCurrentXVelocity = (mouse.x - oPrivate.pXPrev)
            oPrivate.pXVelocity = (oPrivate.pXVelocity + oCurrentXVelocity) / 2.0
            oPrivate.pXPrev = mouse.x

            if (oPrivate.pXVelocity > 15 && mouse.x > parent.width * 0.2) {
                oPrivate.pTracing = false
                oRoot.sgSwipeRight()
            } else {
                mouse.accepted = false
            }
        }

        onSgSwipeRight: {
            if (timer.running) {

            } else {
                timer.restart()
                topBar.standartBack()
                console.log("onSgSwipeRight")
            }
        }
    }
}
