import QtQuick 2.15
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"

Rectangle {
    id: authorMiniCard

    height: parent.height - 10
    width: height / 12 * 9
    radius: height / 20
    //color: "#333"
    color: "#0028292A"
    //border.color: "#282323"
    border.color: light
    border.width: 1

    property string cover: ""
    property string name: "Beatmaker"
    property string style: "music style"

    Rectangle {
        id: authorMiniCardCoverMask

        width: parent.width - blockMargin
        height: width
        radius: width / 20

        //color: "#333"
        color: darkest
        border.color: light
        border.width: 1

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: blockMargin / 2
        }
    }

    Image {
        id: authorMiniCardCover
        source: authorMiniCard.cover

        width: parent.width - blockMargin
        height: width

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: blockMargin / 2
        }

        visible: false
    }

    OpacityMask {
        anchors.fill: authorMiniCardCoverMask
        source: authorMiniCardCover
        maskSource: authorMiniCardCoverMask
    }

    HeaderTextStyle {
        id: authorMiniCardName
        color: "white"
        text: authorMiniCard.name

        font.pointSize: (authorMiniCard.height - authorMiniCardCoverMask.height) / 4

        anchors {
            top: authorMiniCardCoverMask.bottom
            topMargin: blockMargin / 2
            left: parent.left
            leftMargin: blockMargin / 2
        }
    }

    BasicTextStyle {
        id: authorMiniCardStyle

        text: authorMiniCard.style

        font.pointSize: (authorMiniCard.height - authorMiniCardCoverMask.height) / 5

        anchors {
            top: authorMiniCardName.bottom
            topMargin: blockMargin / 4
            left: parent.left
            leftMargin: blockMargin / 2
        }
    }
}
