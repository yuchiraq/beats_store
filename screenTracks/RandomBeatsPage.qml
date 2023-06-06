import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

import "qrc:/cards"
import "qrc:/primitive"
import "qrc:/ui_icons/basic"

Page {
    id: randomBeatsPage

    //contentHeight: randomBeatsColumn.height * 1.5
    anchors.fill: centralScreen
    anchors.topMargin: topBar.height //+ blockMargin
    anchors.bottomMargin: bottomBar.height

    Rectangle {
        anchors.fill: parent
        color: surface
    }

    header: Rectangle {

        DropShadow {
            anchors.fill: parent
            radius: 8
            color: "black"
            source: parent
        }

        id: headerBackground

        width: parent.width
        height: blockMargin * 2 + headerRandomBeats.height
        color: container

        GaussianBlur {
            source: stackView
            anchors.fill: parent1

            radius: 120
            samples: 64
            transparentBorder: false
        }

        Rectangle {
            anchors.fill: parent
            color: container
            opacity: .6

            Divider {
                anchors.bottom: parent.bottom
            }
        }

        Text {
            id: headerRandomBeats
            font {
                //weight: Font.Bold
                family: appFont
                pointSize: blockMargin * 1.3
            }
            color: accent
            text: "<b>Случайные биты</b>"

            anchors {
                top: parent.top
                topMargin: blockMargin
                left: parent.left
                leftMargin: blockMargin
            }
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
                color: container

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
                    source: "qrc:/ui_icons/basic/angle-small-right.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    ColorOverlay {
                        source: parent
                        color: secondary
                        anchors.fill: parent
                    }

                    rotation: 90
                    height: parent.height
                    width: height
                }
            }

            height: blockMargin * 1.6
            width: randomBeatsSelectorText.width + height + 20

            onClicked: {

            }
        }
    }

    ListView {
        id: randomBeatsView

        model: 50

        anchors.fill: parent

        //flickableDirection: Flickable.AutoFlickDirection
        height: contentHeight

        delegate: Item {
            id: randomBeatButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: randomBeat.height + 0.5

            BeatLine {
                id: randomBeat
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                //id_track: modelData != "" ? modelData : "empty arg"
            }

            Divider {
                width: parent.width - blockMargin
                anchors.top: randomBeat.bottom
            }
        }

        //visible: randomBeatsView.count == 5
    }
}
