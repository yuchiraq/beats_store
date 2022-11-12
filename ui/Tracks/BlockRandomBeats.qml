import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import "qrc:/TextStyles"
import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomBeats

    width: mainScreen.width - (blockMargin * 2)
    height: randomBeat1.height * 5 + 5 + headerRandomBeats.height + 30
    radius: width / 20

    color: "#333333"

    HeaderTextStyle {
        id: headerRandomBeats
        text: "Биты"

        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: blockNewRealise.height * 0.1
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
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {
            cover: "qrc:/png/temp/covers/2.png"
            title: "Roll up dat zaza shit"
            author: "1swif"
        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {
            cover: "qrc:/png/temp/covers/balenciaga.jpg"
            title: "Balenciaga"
            author: "Ebone Hoodrich"
        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {
            cover: "qrc:/png/temp/covers/PLINOFFICIAL - Cocaina80%.jpg"
            title: "Cocaina"
            author: "Plinofficial"
        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BeatLine {

        }
    }

}

