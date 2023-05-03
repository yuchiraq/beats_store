import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "../primitive"
import "../cards"

Rectangle {
    id: authorMiniCard

    height: blockMargin * 14
    width: height / 12 * 9
    radius: blockMargin
    border.color: outline

    color: dark

    border.width: 1

    property int id: 0
    property string cover: ""
    property string name: "Beatmaker"
    property string style: "music style"

    Rectangle {
        id: authorMiniCardCoverMask

        width: parent.width
        height: width
        radius: parent.radius

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

    BusyIndicator {
        running: authorMiniCardCover.status === Image.Loading
        anchors.centerIn: authorMiniCardCover
    }

    OpacityMask {
        anchors.fill: authorMiniCardCoverMask
        source: authorMiniCardCover
        maskSource: authorMiniCardCoverMask
    }

    Label {
        id: authorMiniCardName
        color: accent

        //wrapMode: Label.WrapAnywhere
        font.family: appFont
        text: "<strong>" + authorMiniCard.name + "</strong>"

        wrapMode: Label.Wrap

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

        color: secondary

        anchors {
            top: authorMiniCardName.bottom
            topMargin: height / 2
            left: parent.left
            leftMargin: blockMargin / 2
        }
    }

    Rectangle {
        id: likeAuthorOverlay

        color: dark

        anchors.fill: parent
        radius: parent.radius

        opacity: 0
    }

    Image {
        id: likeAuthorImg

        source: "qrc:/ui_icons/solid/heart.svg"

        anchors.centerIn: authorMiniCardCover

        width: likeMin
        height: width

        opacity: 0
    }

    function singleClick() {
        authorPage.author_cover = cover
        authorPage.author_name = name
        authorPage.author_id = id
        if (bottomBar.active == 1) {
            leftScreen.push(authorPage)
        } else if (bottomBar.active == 2) {
            centralScreen.push(authorPage)
        } //else if (bottomBar.active == 3) {
        //leftScreen.push("qrc:/ui/Pages/AlbumPage.qml")
        //}
        topBar.backSwitch()
    }

    function doubleClick() {
        likeAuthor.running = true
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

        onDoubleClicked: likeAuthor.running = true

        onClicked: {
            //            if (timer.running) {
            //                doubleClick()
            //                timer.stop()
            //            } else {
            //                timer.restart()
            //            }
            singleClick()
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
            from: 0
            to: 1
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
            from: 1
            to: 0
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
