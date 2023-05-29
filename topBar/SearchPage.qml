import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/screenTracks"
import "qrc:/cards"
import "qrc:/primitive"

Flickable {
    id: searchScreen

    width: parent

    anchors.fill: stackView
    anchors.topMargin: blockMargin * 3 + blockMargin * 3 + blockMargin * 3

    ListView {
        id: searchBeats

        model: search.items
        anchors.fill: parent

        delegate: Item {
            id: searchAnswer
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - blockMargin
            height: searchBeat.height + 0.5

            BeatLine {
                id: searchBeat
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                id_track: modelData != "" ? modelData : "empty arg"
            }

            Divider {}
        }

        //visible: topBar.selectorPos == 1
    }
}
