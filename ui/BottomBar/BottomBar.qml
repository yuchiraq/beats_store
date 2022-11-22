import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import "qrc:/ui/Tracks"

Rectangle {
    id: bottomBar

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    height: 60
    width: mainScreen.width

    color: darkestTransparency

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
            source: "qrc:/png/interface/user.svg"

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

            leftBottomBarButtonImg.source = "qrc:/png/interface/user (1).svg"
            centralBottomBarButtonImg.source = "qrc:/png/interface/music-alt.svg"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heart.svg"

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
            source: "qrc:/png/interface/music-alt (1).svg"
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

            leftBottomBarButtonImg.source = "qrc:/png/interface/user.svg"
            centralBottomBarButtonImg.source = "qrc:/png/interface/music-alt (1).svg"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heart.svg"

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
            source: "qrc:/png/interface/heart.svg"
            fillMode: Image.PreserveAspectFit

            anchors.centerIn: parent
            height: buttonMin
            //sourceSize: buttonMin

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

            leftBottomBarButtonImg.source = "qrc:/png/interface/user.svg"
            centralBottomBarButtonImg.source = "qrc:/png/interface/music-alt.svg"
            rightBottomBarButtonImg.source = "qrc:/png/interface/heart (1).svg"

            stackView.clear()
            stackView.push(rightScreen)
        }

    }

    Rectangle {
        height: 1
        width: parent.width
        color: outline

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

}
