import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"
import "qrc:/ui/Cards"

Flickable {
    id: centralScreen

    contentHeight: bestTracksColumn.height
    anchors.fill: stackView
    anchors.topMargin: topLogo.height
    anchors.bottomMargin: bottomBar.height

    Column {
        id: bestTracksColumn

        anchors {
            top: mainScreen.top
            //left: mainScreen.left
            //right: mainScreen.right
            topMargin: topLogo.height
            bottomMargin: topLogo.height
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

        BasicTextStyle {
            text: "by Chiraq Concept"

            anchors {
                right: parent.right
                rightMargin: blockMargin
            }
        }

    }
}
