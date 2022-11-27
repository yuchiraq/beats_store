import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/ui/Tracks"

Flickable {
    id: rightScreen

    width: parent

    anchors.fill: stackView
    anchors.topMargin: topBar.height + blockMargin
    anchors.bottomMargin: bottomBar.height

    contentHeight: likedColumn.height

    Column {
        id: likedColumn

        anchors {
            top: mainScreen.top
            topMargin: topBar.height + blockMargin
            bottomMargin: topBar.height
            horizontalCenter: parent.horizontalCenter
        }

        spacing: blockMargin

        Text {
            font.family: appFont
            color: secondary
            text: "<strong>by Chiraq Concept</strong>"

            anchors {
                right: parent.right
                rightMargin: blockMargin
            }
        }

        ProgressBar {
            indeterminate: true
            anchors {

                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

}
