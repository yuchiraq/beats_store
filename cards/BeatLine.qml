import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/primitive"

Rectangle {
    id: beatLine

    width: parent.width
    height: blockMargin * 7

    color: /*selected ? accentTransparency :*/ "transparent"

    radius: blockMargin

    border.width: 0 //selected && id_track != "" ? 0.5 : 0
    border.color: secondary

    clip: true

    Divider {
        anchors.bottom: parent.bottom
        width: parent.width - blockMargin
    }

    Connections {
        target: trackData
    }

    visible: beatLine.id_track != "empty arg" && beatLine.id_track != "0"

    property string id_track: ""
    property string cover: id_track == "" ? "" : "http://" + ip + "/coversMini/" + id_track + ".jpg"
    property string title: id_track == "" ? "" : trackData.getTitle(id_track)
    property string author: id_track == "" ? "" : trackData.getAuthorTitle(
                                                 id_track)
    property string time: id_track == "" ? "" : Math.floor(
                                               timeSec / 60) + ":" + timeCorrector(
                                               Math.floor(timeSec % 60))
    property int timeSec: id_track == "" ? 0 : trackData.getDuration(id_track)
    property int bpm: id_track == "" ? 0 : 1

    property bool selected: musicPlayer.track_id.toString() == id_track

    function timeCorrector(number) {
        if (number <= 9)
            return "0" + number
        return number
    }

    property real backX: 0
    property real backY: 0
    property bool needBack: false

    Rectangle {
        id: beatLineBackground

        color: outline //**//

        width: beatLine.width * 3
        height: width
        radius: width / 2

        x: backX - width / 2
        y: backY - width / 2

        visible: selected //&& id_track != ""
    }

    Rectangle {
        id: backgroundBorder
        anchors.fill: parent
        border.width: px(1)
        border.color: secondary
        color: "transparent"
        radius: parent.radius

        //opacity: selected ? 1 : 0
        visible: selected

        ColorAnimation on border.color {
            id: borderColorOn
            from: surface
            to: accent
            duration: 1000
            running: false
        }

        ColorAnimation on border.color {
            id: borderColorOff
            from: accent
            to: surface
            duration: 500
            running: false
        }
    }

    ParallelAnimation {
        id: touchAnimOn

        NumberAnimation {
            target: beatLineBackground
            property: "width"
            duration: 1000
            easing.type: Easing.InOutQuad
            from: 0
            to: beatLine.width * 3
        }

        NumberAnimation {
            target: backgroundBorder
            property: "opacity"
            duration: 1000
            easing.type: Easing.InOutQuad
            from: 0
            to: 1
        }

        onFinished: {
            if (!beatLineMouseArea.pressed) {
                needBack = true
            }
        }

        onStarted: {
            borderColorOn.restart()
            beatLineBackground.visible = true
            beatLineBackground.opacity = 0.7
        }

        running: false
    }

    ParallelAnimation {
        NumberAnimation {
            id: touchAnimOff
            target: beatLineBackground
            property: "opacity"
            duration: 500
            easing.type: Easing.InOutQuad
            from: 0.7
            to: 0
        }
        NumberAnimation {
            target: backgroundBorder
            property: "opacity"
            duration: 500
            easing.type: Easing.InOutQuad
            from: 1
            to: 0
        }

        onStarted: borderColorOff.restart()
        onFinished: {
            beatLineBackground.width = 0
            beatLineBackground.visible = false
            needBack = false
        }
        running: selected == false && needBack == true
    }

    GaussianBlur {
        source: beatLineCover
        anchors.fill: beatLineCover
        radius: 16
        samples: 16
        transparentBorder: true
        opacity: 1
        visible: selected
    }

    Rectangle {
        id: beatLineCoverMask

        color: container
        border.width: 1
        border.color: outline
        width: blockMargin * 6
        height: width
        anchors.left: parent.left
        anchors.leftMargin: blockMargin / 2
        anchors.verticalCenter: parent.verticalCenter
        radius: selected ? blockMargin / 2 : height / 20
    }

    Image {
        id: beatLineCover
        source: beatLine.cover
        width: parent.height * 0.8
        height: width
        anchors.left: parent.left
        anchors.leftMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter
        visible: false
    }

    OpacityMask {
        anchors.fill: beatLineCoverMask
        source: beatLineCover
        maskSource: beatLineCoverMask
    }

    Item {

        anchors.left: beatLineCoverMask.right
        anchors.leftMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter

        height: beatLineAuthor.height + beatLineName.height

        Text {
            id: beatLineName
            text: beatLine.title

            //font.family: appFont
            color: accent

            font.weight: Font.Medium
            font.pointSize: blockMargin * 1.7
            elide: Text.ElideRight
        }

        Text {

            id: beatLineAuthor
            text: beatLine.author
            //font.family: appFont
            font.pointSize: blockMargin * 1.4
            color: secondary
            anchors.top: beatLineName.bottom
            elide: Text.ElideRight
        }

        Rectangle {
            id: titleMask
            anchors.verticalCenter: beatLineName.verticalCenter
            anchors.leftMargin: blockMargin
            visible: beatLine.title == ""

            height: beatLineName.font.pointSize
            width: beatLine.width / 3

            radius: height / 3

            color: outline
            border.width: 0
            border.color: outline
        }

        Rectangle {
            id: authorMask
            anchors.verticalCenter: beatLineAuthor.verticalCenter
            anchors.leftMargin: blockMargin
            visible: beatLine.author == ""

            height: beatLineAuthor.font.pointSize
            width: beatLine.width / 4

            radius: height / 3

            color: outline
            border.width: 0
            border.color: outline
        }

        Rectangle {
            anchors.verticalCenter: beatLineName.verticalCenter
            anchors.left: titleMask.right
            anchors.leftMargin: beatLine.width - (titleMask.width + blockMargin * 1.5
                                                  + beatLineCoverMask.width + width + blockMargin)
            visible: beatLine.time == ""

            height: beatLineBPMTime.font.pointSize
            width: beatLine.width / 10

            radius: height / 3

            color: outline
            border.width: 0.5
            border.color: outline
        }

        Rectangle {
            anchors.verticalCenter: beatLineAuthor.verticalCenter
            anchors.left: authorMask.right
            anchors.leftMargin: beatLine.width - (authorMask.width + blockMargin * 1.5
                                                  + beatLineCoverMask.width + width + blockMargin)
            visible: beatLine.bpm == 0

            height: beatLineBPMTime.font.pointSize
            width: beatLine.width / 11

            radius: height / 3

            color: outline
            border.width: 0.5
            border.color: outline
        }
    }

    Text {
        id: beatLineBPMTime
        text: time + "\nid: " + id_track

        //font.family: appFont
        anchors.right: parent.right
        anchors.rightMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        visible: beatLine.time != ""

        color: secondary
        font.pointSize: blockMargin * 1.4
    }

    Rectangle {
        id: likeBeatOverlay

        color: container

        anchors.fill: parent

        opacity: 0
    }

    Image {
        id: likeBeatImg

        source: "qrc:/ui_icons/solid/heart.svg"

        anchors.centerIn: beatLineCoverMask

        width: likeMin
        height: width

        opacity: 0
    }

    property int likeMin: beatLineCoverMask.width / 2
    property int likeMax: beatLineCoverMask.width / 1.5
    property int timeAnimation: 100

    SequentialAnimation {
        id: likeBeat

        NumberAnimation {
            target: likeBeatOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0
            to: 0.3
        }

        NumberAnimation {
            target: likeBeatImg
            property: "opacity"
            duration: timeAnimation
            from: 0
            to: 1
        }

        NumberAnimation {
            target: likeBeatImg
            property: "width"
            duration: timeAnimation
            from: likeMin
            to: likeMax
        }

        NumberAnimation {
            target: likeBeatImg
            property: "width"
            duration: timeAnimation
            from: likeMax
            to: likeMin
        }

        NumberAnimation {
            target: likeBeatImg
            property: "opacity"
            duration: timeAnimation
            from: 1
            to: 0
        }

        NumberAnimation {
            target: likeBeatOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0.3
            to: 0
        }

        onStarted: {
            notification.notificationText = beatLine.title + " добавлен"
            notification.start()
        }

        running: false
    }

    function singleClick() {
        musicPlayer.track_id = id_track
        musicPlayer.titlePlayer = title
        musicPlayer.authorPlayer = author

        musicPlayer.timePlayerString = time
        musicPlayer.timePlayerSec = timeSec
        musicPlayer.bpmPlayer = bpm

        beatFunctions.id = id_track
        beatFunctions.title = title
        beatFunctions.author = author
        beatFunctions.time = time
        beatFunctions.bpm = bpm

        musicPlayer.curTime = 0
        musicPlayer.resetPlayerSlider()

        console.log("Beat clicked")
    }

    function doubleClick() {
        likeBeat.running = true
    }

    MouseArea {
        id: beatLineMouseArea
        anchors.fill: parent


        /*Timer {
            id: timerPress
            interval: 40
            onTriggered: {
                if (beatLineMouseArea.pressed)
                    touchAnimOn.restart()
            }
        }*/
        onPressed: {
            backX = mouseX
            backY = mouseY
            console.log("Beat pressed")
            //timerPress.restart()
            touchAnimOn.restart()
        }
        onReleased: {


            /*if (timer.running) {
                timer.stop()
                return
            }*/
            if (!touchAnimOn.running) {
                needBack = true
            }
            console.log("Beat released")
        }
        onClicked: {
            singleClick()
        }
        onDoubleClicked: likeBeat.running = true

        onPressAndHold: {
            beatFunctions.id = id_track
            beatFunctions.starter()
        }
    }
}
