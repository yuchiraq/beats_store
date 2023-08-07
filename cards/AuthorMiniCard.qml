import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "../primitive"
import "../cards"

Rectangle {
    id: authorMiniCard

    height: blockMargin * 16
    width: blockMargin * 12
    radius: blockMargin

    //border.color: authorMouseArea.pressed ? secondary : outline
    //border.width: px(1)
    color: container

    property string author_id: ""
    property string cover: "http://" + ip + "/coversMini/" + author_id + ".jpg"
    property string name: ""
    property string style: ""

    clip: true

    Rectangle {
        id: coverMask

        width: parent.width
        height: width
        radius: parent.radius

        color: outline

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        Rectangle {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            color: parent.color
            width: parent.width
            height: parent.radius
        }
    }

    Image {
        id: coverImg
        source: authorMiniCard.cover

        anchors.fill: coverMask

        visible: false
    }

    OpacityMask {
        anchors.fill: coverMask
        source: coverImg
        maskSource: coverMask
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

            anchors {
                top: parent.top
                left: parent.left
            }

            width: blockMargin * 11
            height: blockMargin * 1.5

            color: outline
            radius: height / 3

            visible: name == ""
        }

        Rectangle {
            id: styleMask

            anchors {
                bottom: parent.bottom
                left: parent.left
            }

            width: blockMargin * 9
            height: blockMargin

            color: outline
            radius: height / 3

            visible: authorMiniCard.style == ""
        }

        Label {
            text: name

            anchors {
                top: parent.top
                left: parent.left
            }

            width: blockMargin * 11

            font {
                weight: Font.Medium
                //family: appFont
                bold: false
                pointSize: parent.height * 0.35 //blockMargin
            }

            color: accent
            elide: Text.ElideRight
        }

        Label {
            text: authorMiniCard.style

            anchors {
                bottom: parent.bottom
                left: parent.left
            }

            width: blockMargin * 11

            font {
                //family: appFont
                bold: false
                pointSize: parent.height * 0.25 //blockMargin * 0.7
            }

            color: secondary
            elide: Text.ElideRight
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: parent.radius
        border.color: outline
        border.width: px(1)

        ColorAnimation on border.color {
            id: borderColorOn
            from: outline
            to: secondary
            duration: 200
            running: false
            onFinished: borderColorOff.restart()
        }
        ColorAnimation on border.color {
            id: borderColorOff
            from: secondary
            to: outline
            duration: 200
            running: false
        }
    }

    MouseArea {
        id: authorMouseArea
        anchors.fill: parent

        onClicked: {
            //authorPage.author_cover = cover
            authorPage.author_name = name
            authorPage.author_id = author_id
            if (bottomBar.active == 1) {
                leftScreen.push(authorPage, StackView.Immediate)
            } else if (bottomBar.active == 2) {
                centralScreen.push(authorPage, StackView.Immediate)
            } //else if (bottomBar.active == 3) {
            //leftScreen.push("qrc:/ui/Pages/AlbumPage.qml")
            //}
            topBar.backSwitch()
        }

        onPressed: {
            if (!borderColorOn.running && !borderColorOff.running)
                borderColorOn.restart()
        }
    }
}
