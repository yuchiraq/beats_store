import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "qrc:/ui/Tracks"

Rectangle {
    id: bottomBar

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    height: parent.height / 14
    width: parent.width

    color: "#df282323"

    property int buttonMin: height * 0.4
    property int buttonMax: height * 0.45

    Button {

        id: leftBottomBarButton

        width: parent.width / 3
        height: parent.height

        anchors.left: parent.left

        contentItem: Image {
            id: leftBottomBarButtonImg
            fillMode: Image.PreserveAspectFit
            source: "qrc:/png/interface/user.png"

            anchors.centerIn: parent
            height: buttonMin
        }

        background: Rectangle {
            color: "#00000000"
        }

        onClicked: {
            leftBottomBarButtonImg.height = buttonMax
            centralBottomBarButtonImg.height = buttonMin
            rightBottomBarButtonImg.height = buttonMin

            leftBottomBarButtonImg.source = "qrc:/png/interface/userActive.png"
            centralBottomBarButtonImg.source = "qrc:/png/interface/music.png"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heart.png"

            stackView.clear()
            stackView.push(leftScreen)
        }

    }

    Button {
        id: centralBottomBarButton

        height: parent.height
        width: parent.width / 3

        anchors.centerIn: parent

        contentItem: Image {
            id: centralBottomBarButtonImg
            source: "qrc:/png/interface/musicActive.png"
            fillMode: Image.PreserveAspectFit

            anchors.centerIn: parent
            height: buttonMax

            ColorOverlay {
                id: centralBottomBarButtonImgOverlay

                color: "#00000000"
            }
        }

        background: Rectangle {
            color: "#00000000"
        }


        onClicked: {

            leftBottomBarButtonImg.height = buttonMin
            centralBottomBarButtonImg.height = buttonMax
            rightBottomBarButtonImg.height = buttonMin

            leftBottomBarButtonImg.source = "qrc:/png/interface/user.png"
            centralBottomBarButtonImg.source = "qrc:/png/interface/musicActive.png"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heart.png"

            stackView.clear()
            stackView.push(centralScreen)
        }
    }

    Button {
        id: rightBottomBarButton

        height: parent.height
        width: parent.width / 3

        anchors.right: parent.right

        contentItem: Image {
            id: rightBottomBarButtonImg
            source: "qrc:/png/interface/heart.png"
            fillMode: Image.PreserveAspectFit

            anchors.centerIn: parent
            height: buttonMin

            ColorOverlay {
                id: rightBottomBarButtonImgOverlay

                color: "#af000000"
            }
        }

        background: Rectangle {
            color: "#00000000"
        }

        onClicked: {

            leftBottomBarButtonImg.height = buttonMin
            centralBottomBarButtonImg.height = buttonMin
            rightBottomBarButtonImg.height = buttonMax

            leftBottomBarButtonImg.source = "qrc:/png/interface/user.png"
            centralBottomBarButtonImg.source = "qrc:/png/interface/music.png"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heartActive.png"

            stackView.clear()
            stackView.push(rightScreen)
        }

    }

}
