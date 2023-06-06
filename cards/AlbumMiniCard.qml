import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: albumMiniCard

    height: blockMargin * 20
    width: blockMargin * 15
    radius: blockMargin
    border.color: albumMouseArea.pressed ? secondary : outline

    color: container

    border.width: 0.5

    property string cover: ""
    property string title: ""
    property string style: ""
    property string author: ""

    clip: true

    DropShadow {
        anchors.fill: coverMask
        verticalOffset: blockMargin / 2
        radius: 8
        color: surface
        source: coverMask
        transparentBorder: true

        visible: false
    }

    Rectangle {
        id: coverMask
        color: outline
        width: parent.width
        height: width

        radius: parent.radius

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        clip: true

        Image {
            id: coverImg
            source: albumMiniCard.cover
            anchors.fill: coverMask

            visible: false
        }
    }

    OpacityMask {
        anchors.fill: coverMask
        maskSource: coverMask
        source: coverImg
    }

    Item {
        anchors {
            top: coverMask.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: blockMargin * 0.5
            bottomMargin: blockMargin * 0.5
            leftMargin: blockMargin * 0.5
            rightMargin: blockMargin * 0.5
        }

        Rectangle {
            id: titleMask

            anchors.top: parent.top
            anchors.left: parent.left

            height: blockMargin * 2
            width: blockMargin * 12

            radius: height / 3

            color: outline

            visible: title == ""
        }

        Rectangle {
            id: authorMask

            anchors.bottom: parent.bottom
            anchors.left: parent.left

            height: blockMargin * 1.5
            width: blockMargin * 10

            radius: height / 3

            color: outline

            visible: author == ""
        }

        Label {
            id: titleLabel

            color: accent

            text: albumMiniCard.title

            font {
                weight: Font.Medium
                family: appFont
                bold: false
                pointSize: parent.height * 0.35 //blockMargin * 1.5
            }

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            elide: Text.ElideRight
        }

        Label {
            id: authorLabel

            color: secondary

            text: albumMiniCard.author

            font {
                family: appFont
                bold: false
                pointSize: parent.height * 0.25 //blockMargin * 1
            }

            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: albumMouseArea
        anchors.fill: parent

        onClicked: {
            albumPage.album_cover = cover
            albumPage.album_title = title
            albumPage.album_author = author
            if (bottomBar.active == 1) {
                leftScreen.push(albumPage, StackView.Immediate)
            } else if (bottomBar.active == 2) {
                centralScreen.push(albumPage, StackView.Immediate)
            } //else if (bottomBar.active == 3) {
            //leftScreen.push("qrc:/ui/Pages/AlbumPage.qml")
            //}
            topBar.backSwitch()
        }
    }
}
