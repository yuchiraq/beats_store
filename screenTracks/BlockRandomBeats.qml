import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"
import "qrc:/primitive"

Rectangle {
    id: blockRandomBeats

    width: mainScreen.width - (blockMargin * 2)
    height: blockMargin * 7 * 5 + 3 + headerRandomBeats.height + blockMargin * 2 + blockMargin
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#333333"
    color: dark
    border.color: outline
    border.width: 0.5

    Text {
        id: headerRandomBeats
        font.family: localFont.name
        text: "<b>Биты</b>"
        color: secondary

        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }

        font.pointSize: blockMargin * 1.3
    }

    Button {
        id: blockRandomBeatsStyleButton

        anchors {
            verticalCenter: headerRandomBeats.verticalCenter
            right: parent.right
            rightMargin: blockMargin
        }

        background: Rectangle {
            anchors.fill: parent
            radius: blockMargin
            border.color: outline
            border.width: 0.5
            color: dark

            Text {

                id: randomBeatsSelectorText
                text: "Случайные"
                font.pointSize: blockMargin * 1.3
                font.family: appFont
                color: secondary

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Image {
                source: "qrc:/png/interface/next.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                rotation: 90
                height: parent.height / 2
                width: height
            }
        }

        height: blockMargin * 1.6
        width: randomBeatsSelectorText.width + height + 20

        onClicked: {
            //styleChooser.styleFor = 1
            console.log("Clicked!!!!!")
            //styleChooser.starter()
            //stackMaskedBackground.visible = true
            menu.open()
        }
    }

    Menu {
        id: menu
        background: Rectangle {
            anchors.top: blockRandomBeatsStyleButton.top
            anchors.horizontalCenter: blockRandomBeatsStyleButton.horizontalCenter
            color: dark
            border.color: outline
            border.width: 0.5
            radius: blockMargin * 1.5
            implicitWidth: blockMargin * 12
            implicitHeight: blockMargin * 12
        }

        onAboutToShow: stackMaskedBackground.visible = true
        onAboutToHide: stackMaskedBackground.visible = false

        font {
            pointSize: blockMargin * 1.4
            family: appFont
        }

        MenuItem {
            text: "Jazz"

            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            Divider {}
        }
        MenuItem {
            text: "K-Pop"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            contentItem: Divider {}
        }
        MenuItem {
            text: "Russian Rock"

            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            contentItem: Rectangle {
                implicitWidth: blockMargin * 6
                implicitHeight: 0.5
                color: outline
            }
        }
        MenuItem {
            text: "UK Drill"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            contentItem: Rectangle {
                implicitWidth: blockMargin * 6
                implicitHeight: 0.5
                color: outline
            }
        }
        MenuItem {
            text: "Drill"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            contentItem: Rectangle {
                implicitWidth: blockMargin * 6
                implicitHeight: 0.5
                color: outline
            }
        }
        MenuItem {
            text: "Pop"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuSeparator {
            contentItem: Rectangle {
                implicitWidth: blockMargin * 6
                implicitHeight: 0.5
                color: outline
            }
        }
        MenuItem {
            text: "Rock"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Trap"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Rap"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "R\&B"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Jazz"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "K-Pop"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Russian Rock"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "UK Drill"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Drill"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Pop"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Rock"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Trap"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "Rap"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
        MenuItem {
            text: "R\&B"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
            }
            background: Rectangle {
                color: dark
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 3
                radius: blockMargin * 1.5
            }
            onClicked: {
                randomBeatsSelectorText.text = text
            }
        }
    }

    Rectangle {
        width: parent.width
        height: 1
        color: outline
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: randomBeatsView.top
    }

    ListView {
        anchors {
            top: headerRandomBeats.bottom
            topMargin: blockMargin
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        model: 5

        visible: randomBeatsView.count == 0

        delegate: Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: blockMargin * 7 + 0.5

            BeatLine {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                id_track: 0
            }

            Divider {
                width: parent.width - blockMargin
                anchors.top: randomBeat.bottom
            }
        }
    }

    ListView {
        id: randomBeatsView

        model: randomBeatsModel

        anchors {
            top: headerRandomBeats.bottom
            topMargin: blockMargin
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        delegate: Item {
            id: randomBeatButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: randomBeat.height + 0.5

            BeatLine {
                id: randomBeat
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                title: Title
                author: Author
                timeSec: TimeSec
                id_track: id_db
            }

            Divider {
                width: parent.width - blockMargin
                anchors.top: randomBeat.bottom
            }
        }
    }
}
