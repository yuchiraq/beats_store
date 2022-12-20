import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Tracks"
import "qrc:/ui/Cards"

Flickable {
    id: searchScreen

    width: parent

    anchors.fill: stackView
    anchors.topMargin: topBar.height + blockMargin
    anchors.bottomMargin: bottomBar.height

    contentHeight: parent.height

    ListView {
        id: searchBeats

        model: searchListModel
        anchors.fill: parent

        //height: database.getQuantity() * (blockMargin * 7 + 0.5)
        delegate: Item {
            id: searchAnswer
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - blockMargin
            height: searchBeat.height + 0.5

            BeatLine {
                id: searchBeat
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                title: Title
                author: Author
                timeSec: TimeSec
                id_track: id_db
                cover: coverURL
            }

            Rectangle {
                width: parent.width
                height: 0.5
                color: outline
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: searchBeat.bottom
            }
        }
    }
}
