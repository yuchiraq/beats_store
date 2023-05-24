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
import QtMultimedia

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

    property string alert: "#E91E63"

    //cols by CQ
    property string container: darkTheme ? "#171519" : "#F0EFF4"
    property string surface: darkTheme ? "#0D0C0D" : "#F1F0EA"

    property string darkestTransparency: darkTheme ? "#C80F0A0F" : "#81F1F0EA"

    property string accent: darkTheme ? "#EAEAFE" : "#534B52"

    property string secondary: darkTheme ? "#E1E1EC" : "#2D232E"

    property string outline: darkTheme ? "#272838" : "#534B52"


    property bool darkTheme: true

    property int blockMargin: mainScreen.width
                              < mainScreen.height ? mainScreen.width / 40 : mainScreen.height / 40

    property string ip: "raw.githubusercontent.com/yuchiraq/beats_store"
    property bool updated: false

    width: 1080 / 2
    height: 1920 / 2
    visible: true
    title: qsTr("beats")

    color: surface

    //visibility: "FullScreen"
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
        color: darkestTransparency
        visible: true
    }

    GaussianBlur {
        source: stackView
        anchors.fill: blurMask

        radius: 100
        samples: 128
        transparentBorder: false

        visible: blurMask.visible
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
        color: surface
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

    DropShadow {
        visible: notification.visible
        anchors.fill: notification
        radius: 8
        color: outline
        source: notification
        transparentBorder: true
    }

    Notification {
        id: notification
    }

    Keys.onBackPressed: {
        topBar.standartBack()
    }

    //    Rectangle {
    //        id: mainBackground

    //        color: accentTransparency

    //        width: 200
    //        height: width
    //        radius: width / 2
    //        x: 202
    //        y: 200
    //    }
}
