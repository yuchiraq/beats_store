import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomBeats

    width: mainScreen.width - (blockMargin * 2)
    height: blockMargin * 6 * 5 + 5 + headerRandomBeats.height + 20 + blockMargin
    //radius: width / 20
    radius: blockMargin * 2
    //color: "#333333"
    color: dark
    border.color: outline
    border.width: 0

    Text {
        id: headerRandomBeats
        font.family: appFont
        text: "<b>Биты</b>"
        color: light

        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: blockMargin * 2
        }
    }

    Column {
        anchors {
            top: headerRandomBeats.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        spacing: 0

        Rectangle {
            width: parent.width
            height: 1
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {

            cover: "qrc:/png/temp/covers/2.png"
            title: "Roll up dat zaza shit"
            author: "1swif"

            time: "2:54"
            timeSec: 174
        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 0.5
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {
            time: "2:54"
            timeSec: 174
            bpm: "159bpm"
            cover: "qrc:/png/temp/covers/balenciaga.jpg"
            title: "Balenciaga"
            author: "Ebone Hoodrich"
        }

        Rectangle {

            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 0.5
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {
            id: kfmfksd
            cover: "qrc:/png/temp/covers/PLINOFFICIAL - Cocaina80%.jpg"
            title: "Cocaina"
            author: "Plinofficial"

            time: "2:22"
            timeSec: 142
        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 0.5
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 0.5
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {

        }
    }

}

