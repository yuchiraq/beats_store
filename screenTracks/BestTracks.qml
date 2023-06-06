import QtQml.Models 2.3
import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtQuick.LocalStorage 2.0
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/primitive"
import "qrc:/cards"

StackView {
    id: centralScreen

    anchors.fill: stackView

    property int lastSortBy: 0

    property string lastRealisesText: "Сначала старые"

    function clearStack() {
        if (centralScreen.depth > 1) {
            centralScreen.clear(StackView.PopTransition)
            centralScreen.push(bestTracksInitial)
            topBar.backSwitch(1)
        }
    }

    initialItem: Flickable {
        id: bestTracksInitial
        contentHeight: blockNewRealise.height * 2 + blockRandomBeats.height
                       + blockRandomAlbums.height + blockRandomAuthors.height
                       + lastRealisesView.height

        anchors.fill: parent
        anchors.topMargin: topBar.height
        anchors.bottomMargin: bottomBar.height

        BlockNewRealise {
            id: blockNewRealise

            anchors {
                top: parent.top
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        BlockRandomBeats {
            id: blockRandomBeats

            anchors {
                top: blockNewRealise.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        BlockRandomAuthors {
            id: blockRandomAuthors

            anchors {
                top: blockRandomBeats.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        BlockRandomAlbums {
            id: blockRandomAlbums

            anchors {
                top: blockRandomAuthors.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        Text {
            id: lastRealisesTitle
            text: "<b>Последние релизы</b>"
            color: accent
            anchors {
                top: blockRandomAlbums.bottom
                topMargin: blockMargin
                left: parent.left
                leftMargin: blockMargin
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font {
                family: appFont
                weight: Font.Bold
                pointSize: blockMargin * 1.3
            }
        }

        Button {
            id: lastRealisesSorter

            anchors {
                verticalCenter: lastRealisesTitle.verticalCenter
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

                    id: lastRealisesSorterText
                    text: "Случайные"
                    font.pointSize: blockMargin * 1.3
                    font.family: appFont
                    color: secondary

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }

                Image {
                    source: "qrc:/png/interface/next.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    rotation: 90
                    height: parent.height / 2
                    width: height
                }
            }

            height: blockMargin * 1.6
            width: lastRealisesSorterText.width + height + 20

            onClicked: {
                styleChooser.styleFor = 4
                styleChooser.starter()
            }
        }

        Divider {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lastRealises.top
        }

        ListView {
            id: lastRealisesView

            anchors.top: lastRealisesTitle.bottom
            anchors.topMargin: blockMargin
            anchors.right: parent.right
            anchors.left: parent.left

            height: contentHeight

            model: ListModel {
                id: lastTracksModel
            }

            property int maxRows: 5

            clip: true

            flickableDirection: Flickable.AutoFlickDirection

            delegate: Component {
                BeatLine {
                    id_track: trackID
                    Divider {
                        anchors.bottom: parent.bottom
                    }
                }
            }

            header: Divider {}

            footer: Button {
                id: moreButton
                anchors {
                    //top: lastRealises.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                Material.theme: Material.Dark
                text: "..."
                width: parent.width / 3

                onClicked: {
                    if (lastRealisesView.model.count < lastRealisesView.maxRows) {
                        notification.notificationText = "Это всё"
                        notification.start()
                        return
                    }

                    lastRealisesView.maxRows += 10

                    console.log("addClick " + lastRealisesView.model.count + " "
                                + (lastRealisesView.model.count
                                   < lastRealisesView.maxRows).toString())

                    updateLastTracks()

                    //visible = lastRealisesView.model.count >= lastRealisesView.maxRows
                }
                visible: true //lastRealisesView.model.count == lastRealisesView.maxRows
            }
        }

        Text {
            font.family: appFont
            color: secondary
            text: "<strong>by Chiraq Concept</strong>\n" + mainScreen.height
                  + " * " + mainScreen.width

            anchors {
                topMargin: blockMargin
                top: lastRealisesView.bottom
                right: parent.right
                rightMargin: blockMargin
                bottomMargin: bottomBar.height + 20
            }
        }
    }

    function update() {

        moveUP()

        lastTracksModel.clear()
        lastRealises.reload()

        lastRealisesView.maxRows = 5
        console.log("add " + lastRealisesView.model.count)
        updateLastTracks()

        blockRandomBeats.updateView()
    }

    Connections {
        target: lastRealises
    }

    function updateLastTracks() {
        var curCount = lastRealisesView.model.count
        var curID = "0"
        while (curCount < lastRealisesView.maxRows) {
            curID = lastRealises.addRow(++curCount)
            if (curID != "0") {
                console.log("add " + curCount + "|" + curID + " | " + lastRealisesView.model.count)
                lastTracksModel.append({
                                           "trackID": curID
                                       })
            }
        }
    }

    function moveUP() {

        bestTracksInitial.contentY = 0
    }
}
