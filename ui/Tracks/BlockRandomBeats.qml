import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import "qrc:/TextStyles"

Rectangle {
    id: blockRandomBeats

    width: mainScreen.width - (blockMargin * 2)
    height: randomBeat1.height * 5 + 5 + headerRandomBeats.height + 30
    radius: width / 20

    color: "#333333"

    HeaderTextStyle {
        id: headerRandomBeats
        text: "Случайные биты"
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

        Rectangle {
            id: randomBeat1

            width: parent.width
            height: headerRandomBeats.anchors.leftMargin * 3

            color: "#00333333"

            Rectangle {
                id: randomBeat1CoverMask
                color: "#282323"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 20
            }

            Image {
                id: randomBeat1Cover
                source: "qrc:/png/temp/covers/2.png"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            OpacityMask {
                anchors.fill: randomBeat1CoverMask
                source: randomBeat1Cover
                maskSource: randomBeat1CoverMask
            }

            BasicTextStyle {
                id: randomBeat1Name
                text: "Roll up dat zaza"
                anchors.left: randomBeat1CoverMask.right
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
            }

            BasicTextStyle {
                id: randomBeat1Author
                text: "1swif"
                anchors.left: randomBeat1Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#D7CCCC"
            }

            BasicTextStyle {
                id: randomBeat1BPMTime
                text: "140bpm\n2:48"
                anchors.right: parent.right
                anchors.rightMargin: headerRandomBeats.anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: randomBeat2

            width: parent.width
            height: headerRandomBeats.anchors.leftMargin * 3

            color: "#00333333"

            Rectangle {
                id: randomBeat2CoverMask
                color: "#282323"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 20
            }

            Image {
                id: randomBeat2Cover
                source: "qrc:/png/temp/covers/trap-no-hook.jpg"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            OpacityMask {
                anchors.fill: randomBeat2CoverMask
                source: randomBeat2Cover
                maskSource: randomBeat2CoverMask
            }

            BasicTextStyle {
                id: randomBeat2Name
                text: "Random beat"
                anchors.left: randomBeat2CoverMask.right
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
            }

            BasicTextStyle {
                id: randomBeat2Author
                text: "Beatmaker"
                anchors.left: randomBeat2Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#D7CCCC"
            }

            BasicTextStyle {
                id: randomBeat2BPMTime
                text: "140bpm\n2:48"
                anchors.right: parent.right
                anchors.rightMargin: headerRandomBeats.anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: randomBeat3

            width: parent.width
            height: headerRandomBeats.anchors.leftMargin * 3

            color: "#00333333"

            Rectangle {
                id: randomBeat3CoverMask
                color: "#282323"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 20
            }

            Image {
                id: randomBeat3Cover
                source: "qrc:/png/temp/covers/PLINOFFICIAL - Cocaina80%.jpg"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            OpacityMask {
                anchors.fill: randomBeat3CoverMask
                source: randomBeat3Cover
                maskSource: randomBeat3CoverMask
            }

            BasicTextStyle {
                id: randomBeat3Name
                text: "Cocaina"
                anchors.left: randomBeat3CoverMask.right
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
            }

            BasicTextStyle {
                id: randomBeat3Author
                text: "Gonfire"
                anchors.left: randomBeat3Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#D7CCCC"
            }

            BasicTextStyle {
                id: randomBeat3BPMTime
                text: "140bpm\n1:48"
                anchors.right: parent.right
                anchors.rightMargin: headerRandomBeats.anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: randomBeat4

            width: parent.width
            height: headerRandomBeats.anchors.leftMargin * 3

            color: "#00333333"

            Rectangle {
                id: randomBeat4CoverMask
                color: "#282323"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 20
            }

            Image {
                id: randomBeat4Cover
                source: "qrc:/png/temp/covers/cover.jpg"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            OpacityMask {
                anchors.fill: randomBeat4CoverMask
                source: randomBeat4Cover
                maskSource: randomBeat4CoverMask
            }

            BasicTextStyle {
                id: randomBeat4Name
                text: "Trap Eat"
                anchors.left: randomBeat4CoverMask.right
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
            }

            BasicTextStyle {
                id: randomBeat4Author
                text: "ogbigtoy"
                anchors.left: randomBeat4Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#D7CCCC"
            }

            BasicTextStyle {
                id: randomBeat4BPMTime
                text: "120bpm\n2:28"
                anchors.right: parent.right
                anchors.rightMargin: headerRandomBeats.anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Rectangle {
            width: parent.width - headerRandomBeats.anchors.leftMargin
            height: 1
            color: "#777"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: randomBeat5

            width: parent.width
            height: headerRandomBeats.anchors.leftMargin * 3

            color: "#00333333"

            Rectangle {
                id: randomBeat5CoverMask
                color: "#282323"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 20
            }

            Image {
                id: randomBeat5Cover
                source: "qrc:/png/temp/covers/balenciaga.jpg"
                width: parent.height * 0.8
                height: width
                anchors.left: parent.left
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            OpacityMask {
                anchors.fill: randomBeat5CoverMask
                source: randomBeat5Cover
                maskSource: randomBeat5CoverMask
            }

            BasicTextStyle {
                id: randomBeat5Name
                text: "Balenciaga"
                anchors.left: randomBeat5CoverMask.right
                anchors.leftMargin: headerRandomBeats.anchors.leftMargin / 2
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
            }

            BasicTextStyle {
                id: randomBeat5Author
                text: "Ebone Hoodrich"
                anchors.left: randomBeat5Name.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#D7CCCC"
            }

            BasicTextStyle {
                id: randomBeat5BPMTime
                text: "180bpm\n3:48"
                anchors.right: parent.right
                anchors.rightMargin: headerRandomBeats.anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

    }

}

