import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import "qrc:/TextStyles"

Rectangle {
    id: beatLine

    width: parent.width
    height: headerRandomBeats.anchors.leftMargin * 3

    color: "#00333333"

    property string cover: "qrc:/png/OG_1.png"
    property string title: "Track name"
    property string author: "Beatmaker"
    property string time: "0:00"
    property string bpm: "000bpm"

    Rectangle {
        id: beatLineCoverMask
        color: "#282323"
        width: parent.height * 0.8
        height: width
        anchors.left: parent.left
        anchors.leftMargin: blockNewRealise.height * 0.05
        anchors.verticalCenter: parent.verticalCenter
        radius: height / 20
    }

    Image {
        id: beatLineCover
        source: beatLine.cover
        width: parent.height * 0.8
        height: width
        anchors.left: parent.left
        anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
        anchors.verticalCenter: parent.verticalCenter
        visible: false
    }

    OpacityMask {
        anchors.fill: beatLineCoverMask
        source: beatLineCover
        maskSource: beatLineCoverMask
    }

    BasicTextStyle {
        id: beatLineName
        text: beatLine.title
        anchors.left: beatLineCoverMask.right
        anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
    }

    BasicTextStyle {
        id: beatLineAuthor
        text: beatLine.author
        anchors.left: beatLineName.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        color: "#D7CCCC"
    }

    BasicTextStyle {
        id: beatLineBPMTime
        text: "140bpm\n2:48"
        anchors.right: parent.right
        anchors.rightMargin: headerRandomBeats.anchors.leftMargin
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

}
