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

}
