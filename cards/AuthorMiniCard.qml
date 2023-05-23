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
    border.color: outline
    border.width: 0.5

    color: dark

    property int id: 0
    property string cover: ""
    property string name: ""
    property string style: ""

    clip: true

    Rectangle {
        id: coverMask

        width: parent.width
        height: width
        radius: parent.radius

        color: accentTransparency

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
    }

    Image {
        id: coverImg
        source: authorMiniCard.cover

        width: parent.width
        height: width

        anchors.centerIn: coverMask

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

            color: accentTransparency
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

            color: accentTransparency
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
                family: appFont
                bold: false
                pointSize: blockMargin
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
                family: appFont
                bold: false
                pointSize: blockMargin * 0.7
            }

            color: secondary
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
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
    }
}
