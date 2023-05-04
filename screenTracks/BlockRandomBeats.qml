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

        MenuItem {
            text: "Jazz"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
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
            contentItem: Rectangle {
                implicitWidth: blockMargin * 6
                implicitHeight: 0.5
                color: outline
            }
        }
        MenuItem {
            text: "Russian Rock"
            font {
                pointSize: blockMargin * 1.4
                family: appFont
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
                //cover: coverURL
            }

            Divider {
                width: parent.width - blockMargin
                anchors.top: randomBeat.bottom
            }
        }
    }

    //    Column {
    //        anchors {
    //            top: headerRandomBeats.bottom
    //            topMargin: 10
    //            left: parent.left
    //            right: parent.right
    //        }

    //        spacing: 0

    //        Rectangle {
    //            width: parent.width
    //            height: 1
    //            color: outline
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }

    //        BeatLine {

    //            cover: "qrc:/png/temp/covers/2.png"
    //            title: "Roll up dat zaza shit"
    //            author: "1swif"

    //            time: "2:54"
    //            timeSec: 174
    //        }

    //        Rectangle {
    //            width: parent.width - headerRandomBeats.anchors.leftMargin
    //            height: 0.5
    //            color: outline
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }

    //        BeatLine {
    //            time: "2:54"
    //            timeSec: 174
    //            bpm: "159"
    //            cover: "qrc:/png/temp/covers/balenciaga.jpg"
    //            title: "Balenciaga"
    //            author: "Ebone Hoodrich"
    //        }

    //        Rectangle {

    //            width: parent.width - headerRandomBeats.anchors.leftMargin
    //            height: 0.5
    //            color: outline
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }

    //        BeatLine {
    //            id: kfmfksd
    //            cover: "qrc:/png/temp/covers/PLINOFFICIAL - Cocaina80%.jpg"
    //            title: "Cocaina"
    //            author: "Plinofficial"

    //            time: "2:22"
    //            timeSec: 142
    //        }

    //        Rectangle {
    //            width: parent.width - headerRandomBeats.anchors.leftMargin
    //            height: 0.5
    //            color: outline
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }

    //        BeatLine {
    //            cover: "https://sun1.velcom-by-minsk.userapi.com/impf/kI8faorZFjW_wzAhTjRHhA4xEjPzARLBPM5rPw/TrfiTANzteA.jpg?size=80x0&quality=90&sign=8c34842dd235bac9f8e18fa98a823405"
    //        }

    //        Rectangle {
    //            width: parent.width - headerRandomBeats.anchors.leftMargin
    //            height: 0.5
    //            color: outline
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }

    //        BeatLine {}
    //    }
}
