import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/ui/Tracks"
import "qrc:/ui"
import "qrc:/ui/Cards"

Flickable {
    id: centralScreen

    contentHeight: bestTracksColumn.height
    anchors.fill: stackView
    anchors.topMargin: topBar.height
    anchors.bottomMargin: bottomBar.height

    Column {
        id: bestTracksColumn

        anchors {
            top: mainScreen.top
            topMargin: topBar.height
            bottomMargin: topBar.height
            horizontalCenter: parent.horizontalCenter
        }

        spacing: blockMargin

        BlockNewRealise {
            id: blockNewRealise

            anchors.horizontalCenter: parent.horizontalCenter
        }

        BlockRandomBeats {
            id: blockRandomBeats

            anchors.horizontalCenter: parent.horizontalCenter
        }

        BlockRandomAuthors {
            id: blockRandomAuthors

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width: blockRandomAuthors.width

            Text {
                text: "<b>Последние релизы</b>"
                color: light
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            BeatLine {
                time: "2:54"
                bpm: "150bpm"
                cover: "qrc:/png/temp/covers/balenciaga.jpg"
                title: "Balenciaga"
                author: "Ebone Hoodrich"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BeatLine {
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BeatLine {
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BeatLine {
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                font.family: appFont
                color: secondary
                text: "<strong>by Chiraq Concept</strong>"

                anchors {
                    right: parent.right
                    rightMargin: blockMargin
                }
            }
        }

    }
}
