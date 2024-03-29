import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/"

Rectangle {
    id: musicPlayer

    property int track_id: 0

    property string titlePlayer: "Title"
    property string authorPlayer: "Author"
    property string coverPlayer: "http://" + ip + "/coversFull/" + track_id + ".jpg"

    property bool play: true
    property bool onRepeat: false

    property string timePlayerString: "0:00"
    property int timePlayerSec: 200
    property int curTime: 0

    property string bpmPlayer: "000"

    visible: track_id != 0
    anchors.fill: parent

    color: "#00000000"
    MouseArea {
        id: musicPlayerBackMouseArea

        anchors.fill: parent
        visible: false

        onClicked: {
            playerOnMinClick()
        }
    }

    function playerPPclick() {
        if (!play) {
            play = true
            mediaPlayer.play()
            musicPlayerMinPPImg.source = "qrc:/png/interface/pause.svg"
            musicPlayerMaxPPImg.source = "qrc:/png/interface/pause.svg"
            musicPLayerMaxPPShadow.radius = 4
        } else {
            play = false
            mediaPlayer.pause()
            musicPlayerMinPPImg.source = "qrc:/ui_icons/solid/play.svg"
            musicPlayerMaxPPImg.source = "qrc:/ui_icons/solid/play.svg"
            musicPLayerMaxPPShadow.radius = 7
        }
    }

    property int timeAnimation: 100

    Rectangle {
        id: musicPlayerBlock

        width: mainScreen.width
        height: blockMargin * 3

        color: container
        opacity: .8

        anchors {
            bottom: parent.bottom
            bottomMargin: bottomBar.height
            left: parent.left
            right: parent.right
        }

        MouseArea {
            anchors.fill: parent
            signal sgSwipeLeft
            signal sgSwipeRight
            signal sgSwipeDown
            signal sgSwipeUp

            QtObject {

                property bool pTracing: false
                property real pXVelocity: 0.0
                property real pYVelocity: 0.0
                property int pXPrev: 0
                property int pYPrev: 0

                id: oPrivate
            }

            id: oRoot
            preventStealing: true

            onPressed: {

                oPrivate.pTracing = true
                oPrivate.pXVelocity = 0
                oPrivate.pYVelocity = 0
                oPrivate.pXPrev = mouse.x
                oPrivate.pYPrev = mouse.y
            }

            onPositionChanged: {

                if (!oPrivate.pTracing)
                    return

                var oCurrentXVelocity = (mouse.x - oPrivate.pXPrev)
                oPrivate.pXVelocity = (oPrivate.pXVelocity + oCurrentXVelocity) / 2.0
                oPrivate.pXPrev = mouse.x

                var oCurrentYVelocity = (mouse.y - oPrivate.pYPrev)
                oPrivate.pYVelocity = (oPrivate.pXVelocity + oCurrentYVelocity) / 2.0
                oPrivate.pYPrev = mouse.y

                if (oPrivate.pXVelocity > 15 && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeRight()
                } else if (oPrivate.pXVelocity < -15
                           && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeLeft()
                } else if (oPrivate.pYVelocity > 5
                           && mouse.y > parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeDown()
                } else if (oPrivate.pYVelocity < -2
                           && mouse.y < parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeUp()
                }
            }

            onPressAndHold: console.log("onPressAndHold")
            onSgSwipeLeft: console.log("onSgSwipeLeft")
            onSgSwipeDown: {
                if (parent.height != blockMargin * 3) {
                    playerOnMinClick()
                }
            }
            onSgSwipeRight: console.log("onSgSwipeRight")
            onSgSwipeUp: {
                if (parent.height == blockMargin * 3) {
                    playerOnMaxClick()
                } else {
                    beatFunctions.starter()
                }

                console.log("onSgSwipeUp")
            }
            onReleased: console.log("onReleased")

            onClicked: {
                if (parent.height == blockMargin * 3) {
                    playerOnMaxClick()
                }
            }
        }

        Item {

            id: musicPlayerMin

            anchors.fill: parent

            Text {
                id: musicPlayerMinTitle

                text: titlePlayer

                //font.family: appFont
                font.pointSize: blockMargin * 1.5

                color: accent

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: blockMargin * 2
                }
            }

            Text {
                id: musicPlayerMinAuthor

                text: authorPlayer

                //font.family: appFont
                font.pointSize: blockMargin * 1.5

                color: secondary

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: musicPlayerMinTitle.right
                    leftMargin: blockMargin
                }
            }

            Text {
                id: musicPlayerMinCurTime

                text: Math.floor(playerSlider.value / 60) + ":" + timeCorrector(
                          Math.floor(playerSlider.value % 60))

                font.pointSize: blockMargin * 1.5

                color: secondary

                anchors {
                    right: musicPlayerMinPP.left
                    rightMargin: blockMargin
                    verticalCenter: parent.verticalCenter
                }

                function timeCorrector(number) {
                    if (number <= 9)
                        return "0" + number
                    return number
                }
            }

            Button {
                id: musicPlayerMinPP

                width: blockMargin * 4
                height: width

                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: blockMargin
                }

                contentItem: Image {
                    id: musicPlayerMinPPImg
                    source: "qrc:/png/interface/pause.svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    height: blockMargin * 4
                    width: height
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    playerPPclick()
                }
            }

            Rectangle {
                height: 0.5
                width: parent.width - blockMargin * 2
                color: outline

                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        //animation and max from here
        Item {
            id: musicPlayerMax

            anchors.fill: parent

            visible: true
            opacity: 0

            DropShadow {
                anchors.fill: musicPlayerMaxCoverMask
                transparentBorder: true
                horizontalOffset: -8
                verticalOffset: 8
                radius: 12.0
                color: "#40000000"
                source: musicPlayerMaxCoverMask
            }

            Rectangle {
                id: musicPlayerMaxCoverMask
                width: parent.width //* 0.8
                height: width

                radius: blockMargin * 2 //1.7

                color: container

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    //topMargin: parent.width * 0.1
                }
                smooth: true
            }

            Image {
                id: musicPlayerMaxCoverImg

                source: coverPlayer

                anchors {
                    fill: musicPlayerMaxCoverMask
                    centerIn: musicPlayerMaxCoverMask
                }

                visible: false
            }

            OpacityMask {
                anchors.fill: musicPlayerMaxCoverMask
                source: musicPlayerMaxCoverImg
                maskSource: musicPlayerMaxCoverMask
            }

            BusyIndicator {
                running: musicPlayerMaxCoverImg.status === Image.Loading
                anchors.centerIn: musicPlayerMaxCoverImg
            }

            Rectangle {
                id: topLinePlayer

                width: 80
                height: 4

                color: accent

                radius: 2

                anchors {
                    top: parent.top
                    topMargin: blockMargin
                    horizontalCenter: parent.horizontalCenter
                }
            }

            //            Rectangle {
            //                id: sliderBack
            //                color: darkest
            //                width: parent.width
            //                height: blockMargin * 5
            //                radius: blockMargin * 2
            //                anchors {
            //                    bottom: musicPlayerMaxCoverImg.bottom
            //                    horizontalCenter: musicPlayerMaxCoverImg.horizontalCenter
            //                }

            //                opacity: 1
            //            }

            //            FastBlur {
            //                id: bluredSliderBack
            //                anchors.fill: musicPlayerMaxCoverImg
            //                source: musicPlayerMaxCoverImg
            //                radius: 60
            //                visible: true
            //            }
            //            OpacityMask {
            //                source: bluredSliderBack
            //                maskSource: sliderBack
            //                anchors.fill: bluredSliderBack
            //            }
            Rectangle {
                id: playerSliderBack
                color: surface
                width: parent.width
                height: blockMargin * 5
                radius: blockMargin * 2
                anchors {
                    bottom: musicPlayerMaxCoverImg.bottom
                    horizontalCenter: musicPlayerMaxCoverImg.horizontalCenter
                }

                opacity: 0.4
            }

            Slider {
                id: playerSlider
                value: curTime
                to: timePlayerSec

                width: parent.width * 0.6

                anchors {
                    //horizontalCenter: parent.horizontalCenter
                    //bottom: musicPlayerMaxCoverMask.bottom
                    //bottomMargin: blockMargin
                    centerIn: playerSliderBack
                }

                background: Rectangle {
                    x: playerSlider.leftPadding
                    y: playerSlider.topPadding + playerSlider.availableHeight / 2 - height / 2
                    implicitWidth: playerSlider.width
                    implicitHeight: 4
                    width: implicitWidth
                    height: implicitHeight
                    radius: height / 2
                    color: outline

                    Rectangle {
                        width: playerSlider.visualPosition * parent.width
                        height: parent.height
                        color: accent
                        radius: height / 2
                    }
                }

                handle: Rectangle {
                    x: playerSlider.leftPadding + playerSlider.visualPosition
                       * (playerSlider.availableWidth /*- width*/
                          )
                    y: playerSlider.topPadding + playerSlider.availableHeight / 2 - height / 2
                    implicitWidth: playerSlider.pressed ? 20 : 16
                    implicitHeight: playerSlider.pressed ? 20 : 16
                    radius: height / 2
                    color: playerSlider.pressed ? accent : secondary
                    border.color: "#50EAEAFE"
                    border.width: playerSlider.pressed ? 5 : 1
                }

                ToolTip {
                    parent: playerSlider.handle
                    //visible: playerSlider.pressed
                    visible: false
                    text: pad(Math.floor(value / 60)) + ":" + pad(
                              Math.floor(value % 60))
                    y: parent.height

                    readonly property int value: playerSlider.valueAt(
                                                     playerSlider.position)

                    function pad(number) {
                        if (number <= 9)
                            return "0" + number
                        return number
                    }
                }
            }

            Text {
                id: musicPlayerMaxCurTime

                text: Math.floor(playerSlider.value / 60) + ":" + timeCorrector(
                          Math.floor(playerSlider.value % 60))

                color: secondary

                anchors {
                    left: musicPlayerMaxCoverMask.left
                    leftMargin: blockMargin * 2
                    verticalCenter: playerSlider.verticalCenter
                }

                font.pointSize: blockMargin * 1.5

                function timeCorrector(number) {
                    if (number <= 9)
                        return "0" + number
                    return number
                }
            }

            Text {
                id: musicPlayerMaxTime

                text: timePlayerString

                color: secondary
                font.pointSize: blockMargin * 1.5

                anchors {
                    rightMargin: blockMargin * 2
                    right: musicPlayerMaxCoverMask.right
                    verticalCenter: playerSlider.verticalCenter
                }
            }

            Label {
                id: musicPlayerMaxTitle
                text: titlePlayer

                color: "#FFF"
                //font.family: appFont
                font.bold: true
                font.pointSize: blockMargin * 2

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: playerSlider.bottom
                    topMargin: 10
                }
            }

            Label {
                id: musicPlayerMaxAuthor
                text: authorPlayer

                color: secondary
                //font.family: appFont
                font.bold: false
                font.pointSize: blockMargin * 1.7
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: musicPlayerMaxTitle.bottom
                    topMargin: 5
                }
            }

            DropShadow {
                id: musicPLayerMaxPPShadow
                anchors.fill: musicPlayerMaxPPRectangle
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 2
                radius: 7
                opacity: 1
                color: "#40000000"
                source: musicPlayerMaxPPRectangle
            }

            Rectangle {
                id: musicPlayerMaxPPRectangle
                anchors.fill: musicPlayerMaxPP
                anchors.centerIn: musicPlayerMaxPP
                radius: blockMargin
                color: surface
            }

            Button {
                id: musicPlayerMaxPP

                width: parent.width * 0.15
                height: width

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: musicPlayerMaxAuthor.bottom
                    topMargin: 40
                }

                contentItem: Image {
                    id: musicPlayerMaxPPImg
                    source: "qrc:/png/interface/pause.svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    height: parent.height
                    smooth: true
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    playerPPclick()
                }
            }

            DropShadow {
                id: playerRepeatShadow
                anchors.fill: playerRepeatRectangle
                transparentBorder: true
                horizontalOffset: 2
                verticalOffset: 2
                radius: 7

                color: "#40000000"
                source: playerRepeatRectangle
            }

            Rectangle {
                id: playerRepeatRectangle
                anchors.fill: playerRepeat
                anchors.centerIn: playerRepeat
                radius: blockMargin
                color: surface
            }

            Button {
                id: playerRepeat

                width: musicPlayerMaxPP.height * 0.7
                height: width

                anchors {
                    left: musicPlayerMaxPP.right
                    leftMargin: parent.width * 0.1
                    verticalCenter: musicPlayerMaxPP.verticalCenter
                }

                contentItem: Image {
                    id: playerRepeatImg
                    source: "qrc:/png/interface/arrows-repeat (1).svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: parent.height
                    smooth: true
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    if (onRepeat) {
                        onRepeat = false
                        playerRepeatImg.source = "qrc:/png/interface/arrows-repeat (1).svg"
                        playerRepeatShadow.radius = 7
                    } else {
                        onRepeat = true
                        playerRepeatImg.source = "qrc:/png/interface/arrows-repeat.svg"
                        playerRepeatShadow.radius = 4
                    }
                }
            }

            DropShadow {
                id: playerFunctionsShadow
                anchors.fill: playerFunctionsRectangle
                transparentBorder: true
                horizontalOffset: -2
                verticalOffset: 2
                radius: 7

                color: "#40000000"
                source: playerFunctionsRectangle
            }

            Rectangle {
                id: playerFunctionsRectangle
                anchors.fill: playerFunctions
                anchors.centerIn: playerFunctions
                radius: blockMargin
                color: surface
            }

            Button {
                id: playerFunctions

                width: musicPlayerMaxPP.height * 0.7
                height: width

                anchors {
                    right: musicPlayerMaxPP.left
                    rightMargin: parent.width * 0.1
                    verticalCenter: musicPlayerMaxPP.verticalCenter
                }

                contentItem: Image {
                    id: playerFunctionsImg
                    source: "qrc:/png/interface/menu-burger.svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: parent.height
                    smooth: true
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    beatFunctions.starter()
                }
            }
        }

        ParallelAnimation {
            id: musicPlayerOnMax

            running: false

            NumberAnimation {
                target: musicPlayerBlock
                property: "radius"
                duration: timeAnimation
                from: 0
                to: blockMargin * 2
            }

            NumberAnimation {
                target: musicPlayerBlock
                property: "height"
                duration: timeAnimation
                from: 40
                to: mainScreen.height - 120
            }

            NumberAnimation {
                target: musicPlayerBlock
                property: "anchors.bottomMargin"
                duration: timeAnimation
                from: bottomBar.height
                to: 0
            }

            NumberAnimation {
                target: musicPlayerMax
                property: "opacity"
                duration: timeAnimation
                from: 0
                to: 1
            }

            NumberAnimation {
                target: topLinePlayer
                property: "width"
                duration: timeAnimation
                from: 0
                to: 60
            }

            onFinished: {
                //musicPlayerShadow.visible = true
                musicPlayerBackMouseArea.visible = true
            }
        }

        ParallelAnimation {
            id: musicPlayerOnMin

            running: false

            NumberAnimation {
                target: musicPlayerBlock
                property: "radius"
                duration: timeAnimation
                from: blockMargin * 2
                to: 0
            }

            NumberAnimation {
                target: musicPlayerBlock
                property: "height"
                duration: timeAnimation
                from: mainScreen.height - 120
                to: blockMargin * 3
            }

            NumberAnimation {
                target: musicPlayerBlock
                property: "anchors.bottomMargin"
                duration: timeAnimation
                from: 0
                to: bottomBar.height
            }

            NumberAnimation {
                target: musicPlayerMax
                property: "opacity"
                duration: timeAnimation
                from: 1
                to: 0
            }

            NumberAnimation {
                target: topLinePlayer
                property: "width"
                duration: timeAnimation
                from: 60
                to: 0
            }

            onFinished: {
                //musicPlayerShadow.visible = true
                musicPlayerBackMouseArea.visible = false
                //playerCoverBackgroundTrimed.visible = false
                //playerCoverBackgroundOverlayTrimed.visible = false
            }
        }
    }

    function playerOnMaxClick() {
        //musicPlayerShadow.visible = true
        musicPlayerOnMax.running = true
        musicPlayerMax.visible = true
        musicPlayerMin.visible = false
        musicPlayerBlock.color = surface
        musicPlayer.color = "#90000000"

        beatFunctions.title = titlePlayer
        beatFunctions.author = authorPlayer
        beatFunctions.time = timePlayerString
        beatFunctions.bpm = bpmPlayer
    }

    function playerOnMinClick() {
        musicPlayerOnMin.running = true
        musicPlayerMax.visible = false
        //musicPlayerShadow.visible = false
        musicPlayerMin.visible = true
        musicPlayerBlock.color = darkestTransparency
        musicPlayer.color = "#00000000"
        console.log("onSgSwipeDown")
    }

    function resetPlayerSlider() {
        playerSlider.value = 0
    }
}
