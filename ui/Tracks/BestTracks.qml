import QtQuick 2.15
import QtQuick.Controls

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"


ScrollView {
    id: centralScreen

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

    ScrollBar.horizontal.interactive: false
    ScrollBar.vertical.interactive: true

    contentWidth: width
    contentHeight: blockRandomBeats.height * 5

    property int blockMargin: mainScreen.width / 40

    Column {
        id: bestTracksColumn

        anchors.fill: parent
        anchors.topMargin: topLogo.height

        spacing: blockMargin * 1.5

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

        BasicTextStyle {
            text: "by Chiraq Concept"

            anchors {
                right: parent.right
                rightMargin: blockMargin
            }
        }

    }
}


