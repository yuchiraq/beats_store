import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import "qrc:/TextStyles"

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

    Item {

        anchors.left: beatLineCoverMask.right
        anchors.leftMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter

        height: beatLineAuthor.height + beatLineName.height

        BasicTextStyle {
            id: beatLineName
            text: beatLine.title
            //anchors.left: beatLineCoverMask.right
            //anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
            //anchors.verticalCenter: parent.verticalCenter
            //anchors.bottomMargin: height / 2
            color: "white"
        }

        BasicTextStyle {
            id: beatLineAuthor
            text: beatLine.author
    //        anchors.left: beatLineName.right
    //        anchors.leftMargin: 5
            //anchors.left: beatLineCoverMask.right
            //anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top: beatLineName.bottom
            //anchors.topMargin: height / 2
        }
    }

    BasicTextStyle {
        id: beatLineBPMTime
        text: time + "\n" + bpm
        anchors.right: parent.right
        anchors.rightMargin: blockMargin
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHRight
        verticalAlignment: Text.AlignVCenter
        color: secondary
    }

}
