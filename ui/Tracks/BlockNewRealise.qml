import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import "qrc:/ui/Cards"

Item {
    id: blockNewRealise

    width: mainScreen.width - blockMargin * 2
    height: width / 2 * 1

    anchors{
        leftMargin: blockMargin
        rightMargin: blockMargin
    }

    SwipeView {
        id: view
        currentIndex: 2
        anchors.fill: parent
        spacing: blockMargin

        NewBeat {}

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«CLASSIC PACK III»"
            cover: "qrc:/png/temp/cp3.jpg"
            border.width: 0
        }

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«162 pack 3»"
            cover: "qrc:/png/temp/162-3.jpg"
            border.width: 0
        }

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«162 pack 2»"
            cover: "qrc:/png/temp/162-2.jpg"
            border.width: 0
        }

        NewBeat {

        }

    }

    PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
