import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Tracks"
import "qrc:/ui"

Rectangle {
    id: albumMiniCard

    height: blockMargin * 9
    width: blockMargin * 21
    radius: blockMargin
    border.color: outline

    color: dark

    border.width: 1

    property string cover: ""
    property string title: "Album"
    property string style: "Style"
    property string author: "Author"

    Rectangle {
        id: albumMiniCardCoverMask

        width: parent.height
        height: width
        radius: parent.radius

        //color: "#333"
        color: darkVariant
        border.color: outline
        border.width: 1

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            //topMargin: blockMargin / 2
        }
    }

    Image {
        id: albumMiniCardCover
        source: albumMiniCard.cover

        width: parent.height
        height: width

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            //topMargin: blockMargin / 2
        }

        visible: false
    }

    OpacityMask {
        anchors.fill: albumMiniCardCoverMask
        source: albumMiniCardCover
        maskSource: albumMiniCardCoverMask
    }

    Item {
        anchors {
            verticalCenter: parent.verticalCenter
            left: albumMiniCardCover.right
            leftMargin: blockMargin / 2
            right: parent.right
        }

        height: albumMiniCardAuthor.height + albumMiniCardTitle.height + albumMiniCardStyle.height

        Label {
            id: albumMiniCardTitle
            color: "white"

            //wrapMode: Label.WrapAnywhere
            font.family: appFont
            text: "<strong>" + albumMiniCard.title + "</strong>"
        }

        Text {
            id: albumMiniCardAuthor

            text: albumMiniCard.author

            font.family: appFont

            color: secondary

            anchors.top: albumMiniCardTitle.bottom

            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
        }

        Text {
            id: albumMiniCardStyle

            text: albumMiniCard.style

            font.family: appFont

            color: light

            anchors.top: albumMiniCardAuthor.bottom

            font.pointSize: albumMiniCardTitle.font.pointSize * 0.8
        }
    }

    Rectangle {
        id: likeAlbumOverlay

        color: dark

        anchors.fill: parent
        radius: parent.radius

        opacity: 0
    }

    Image {
        id: likeAlbumImg

        source: "qrc:/png/interface/heart (1).svg"

        anchors.centerIn: albumMiniCardCover

        width: likeMin
        height: width

        opacity: 0
    }


    function singleClick(){

    }

    function doubleClick(){
        likeAlbum.running = true
    }

    MouseArea {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Timer {
            id: timer
            interval: 250
            onTriggered: singleClick()
        }

        onClicked: {
            if (timer.running) {
                doubleClick()
                timer.stop()
            } else {
                timer.restart()
            }
        }
    }

    property int likeMin: albumMiniCardCover.height / 2
    property int likeMax: albumMiniCardCover.height / 1.5
    property int timeAnimation: 100

    SequentialAnimation {
        id: likeAlbum

        NumberAnimation {
            target: likeAlbumOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0
            to: 0.3
        }

        NumberAnimation {
            target: likeAlbumImg
            property: "opacity"
            duration: timeAnimation
            from: 0; to: 1
        }

        NumberAnimation {
            target: likeAlbumImg
            property: "width"
            duration: timeAnimation
            from: likeMin
            to: likeMax
        }

        NumberAnimation {
            target: likeAlbumImg
            property: "width"
            duration: timeAnimation
            from: likeMax
            to: likeMin
        }

        NumberAnimation {
            target: likeAlbumImg
            property: "opacity"
            duration: timeAnimation
            from: 1; to: 0
        }

        NumberAnimation {
            target: likeAlbumOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0.3
            to: 0
        }

        running: false
    }
}
