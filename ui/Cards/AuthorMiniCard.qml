import QtQuick 2.15
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Tracks"
import "qrc:/ui"

Rectangle {
    id: authorMiniCard

    height: blockMargin * 12
    width: height / 12 * 9
    radius: height / 20
    border.color: outline

    color: "#0028292A"

    border.width: 1

    property string cover: ""
    property string name: "Beatmaker"
    property string style: "music style"

    Rectangle {
        id: authorMiniCardCoverMask

        width: parent.width
        height: width
        radius: width / 20

        //color: "#333"
        color: darkVariant
        border.color: outline
        border.width: 1

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            //topMargin: blockMargin / 2
        }
    }

    Image {
        id: authorMiniCardCover
        source: authorMiniCard.cover

        width: parent.width
        height: width

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            //topMargin: blockMargin / 2
        }

        visible: false
    }

    OpacityMask {
        anchors.fill: authorMiniCardCoverMask
        source: authorMiniCardCover
        maskSource: authorMiniCardCoverMask
    }

    Label {
        id: authorMiniCardName
        color: "white"

        wrapMode: Label.WrapAnywhere
        font.family: appFont
        text: "<strong>" + authorMiniCard.name + "</strong>"

        font.pointSize: (authorMiniCard.height - authorMiniCardCoverMask.height) / 3
        height: (authorMiniCard.height - authorMiniCardCoverMask.height) / 3

        anchors {
            top: authorMiniCardCoverMask.bottom
            topMargin: blockMargin / 4
            left: parent.left
            leftMargin: blockMargin / 2
            right: parent.right
            rightMargin: blockMargin / 2
        }
    }

    Text {
        id: authorMiniCardStyle

        text: authorMiniCard.style

        font.pointSize: (authorMiniCard.height - authorMiniCardCoverMask.height) / 4

        font.family: appFont

        color: light

        anchors {
            top: authorMiniCardName.bottom
            //topMargin: blockMargin / 4
            left: parent.left
            leftMargin: blockMargin / 2
        }
    }



    Image {
        id: likeAuthorImg

        source: "qrc:/png/interface/heart (1).svg"

        anchors.centerIn: authorMiniCardCover

        width: likeMin
        height: width

        opacity: 0
    }

    Rectangle {
        id: likeAuthorOverlay

        color: outline

        anchors.fill: parent
        radius: parent.radius

        opacity: 0
    }

    MouseArea {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        onDoubleClicked: {
            likeAuthor.running = true
        }
    }

    property int likeMin: authorMiniCardCover.width / 2
    property int likeMax: authorMiniCardCover.width / 1.5
    property int timeAnimation: 100

    SequentialAnimation {
        id: likeAuthor

        NumberAnimation {
            target: likeAuthorOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0
            to: 0.3
        }

        NumberAnimation {
            target: likeAuthorImg
            property: "opacity"
            duration: timeAnimation
            from: 0; to: 1
        }

        NumberAnimation {
            target: likeAuthorImg
            property: "width"
            duration: timeAnimation
            from: likeMin
            to: likeMax
        }

        NumberAnimation {
            target: likeAuthorImg
            property: "width"
            duration: timeAnimation
            from: likeMax
            to: likeMin
        }

        NumberAnimation {
            target: likeAuthorImg
            property: "opacity"
            duration: timeAnimation
            from: 1; to: 0
        }

        NumberAnimation {
            target: likeAuthorOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0.3
            to: 0
        }

        running: false
    }
}
