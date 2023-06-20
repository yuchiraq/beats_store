import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"

Rectangle {
    id: blockRandomAlbums

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAlbums.height + blockMargin * 2 + blockMargin + blockMargin * 20
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: container

    border.color: outline
    border.width: px(1)

    clip: true

    Text {
        id: headerRandomAlbums

        font {
            weight: Font.Bold
            //family: appFont
            pointSize: blockMargin * 1.3
        }
        color: accent

        text: "<b>Альбомы</b>"
        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }
    }

    ComboBox {
        id: blockRandomAlbumsStyleButton

        anchors {
            verticalCenter: headerRandomAlbums.verticalCenter
            right: parent.right
            rightMargin: blockMargin
        }

        background: Rectangle {
            height: blockMargin * 1.6
            width: 60
            radius: blockMargin
            border.color: outline
            border.width: 0.5
            color: container
        }

        indicator: Image {
            source: "qrc:/ui_icons/basic/angle-small-right.svg"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10

            rotation: 90
            height: parent.height
            width: height

            ColorOverlay {
                source: parent
                color: secondary
                anchors.fill: parent
            }
        }

        width: 60
        height: blockMargin * 1.6

        //width: randomAlbumsSelectorText.width + height + 20
        model: ["Trap", "R\&B", "Rock", "Rap", "Drill", "Pop", "Trap", "R\&B", "Rock", "Rap", "Drill", "Pop", "Trap", "R\&B", "Rock", "Rap", "Drill", "Pop", "Trap", "R\&B", "Rock", "Rap", "Drill", "Pop"]

        //        onClicked: {
        //            styleChooser.styleFor = 3
        //            console.log("Clicked!!!!!")
        //            styleChooser.starter()
        //        }
    }

    ListView {
        id: randomAlbumsList

        orientation: ListView.Horizontal

        anchors {
            top: headerRandomAlbums.bottom
            topMargin: blockMargin
            left: parent.left
            right: parent.right
            leftMargin: 1
            rightMargin: 1
        }

        clip: true

        header: Rectangle {
            width: blockMargin
        }

        footer: Button {
            onClicked: {
                var i = 0
                while (i < 1000) {
                    i++
                    myModel.append({
                                       "titleNew": "162 pack 2"
                                   })
                }
            }
        }
        width: parent.width - 2
        height: parent.height - headerRandomAlbums.height - 20

        model: ListModel {
            id: myModel
            ListElement {
                titleNew: ""
            }
        }

        spacing: blockMargin

        delegate: AlbumMiniCard {
            title: titleNew
            Component.onCompleted: console.log("created:", index)
            Component.onDestruction: console.log("destroyed:", index)
        }
    }
}
