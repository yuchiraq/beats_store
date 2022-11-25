import QtQuick
import QtQuick.Controls.Material

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

    property int buttonMin: 24
    property int buttonMax: 27

    property int active: 2

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
            active = 1
            topBar.backSwitch()
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
            active = 2
            topBar.backSwitch()
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

            smooth: true
            anchors.centerIn: parent
            height: buttonMin
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
            active = 3
            topBar.backSwitch()
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
