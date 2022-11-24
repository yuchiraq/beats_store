import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: beatLine

    width: parent.width
    height: blockMargin * 6

    color: "#00333333"

    property string cover: ""
    property string title: "Track name"
    property string author: "Beatmaker"
    property string time: "0:00"
    property string bpm: "000bpm"

    Rectangle {
        id: beatLineCoverMask
        //color: "#282323"
        color: darkVariant
        border.width: 1
        border.color: outline
        width: parent.height * 0.8
        height: width
        anchors.left: parent.left
        anchors.leftMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter
        radius: height / 20
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

            font.family: appFont

            color: "white"
        }

        Text {
            font.pointSize: beatLineName.height / 1.5
            id: beatLineAuthor
            text: beatLine.author
            font.family: appFont
            color: light
            anchors.top: beatLineName.bottom
        }
    }

    Text {
        id: beatLineBPMTime
        text: time + "\n" + bpm
        font.family: appFont

        anchors.right: parent.right
        anchors.rightMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: secondary
    }

    Rectangle {
        id: likeBeatOverlay

        color: outline

        anchors.fill: parent

        opacity: 0
    }

    Image {
        id: likeBeatImg

        source: "qrc:/png/interface/heart (1).svg"

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
            from: 0; to: 1
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
            from: 1; to: 0
        }

        NumberAnimation {
            target: likeBeatOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0.3
            to: 0
        }

        running: false
    }

    MouseArea {
        anchors.fill: parent

        onDoubleClicked: {
            likeBeat.running = true
        }

        onClicked: {
            musicPlayer.titlePlayer = title
            musicPlayer.authorPlayer = author
            musicPlayer.coverPlayer = cover
            musicPlayer.visible = true
            bottomShadow.enabled = false
            playerShadow.enabled = true
        }
    }

}
