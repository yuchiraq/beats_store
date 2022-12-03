import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Cards"

Item {
    id: blockNewRealise

    width: mainScreen.width - blockMargin * 2
    height: width / 2 * 1

    anchors{
        leftMargin: blockMargin
        rightMargin: blockMargin
    }

    DropShadow {
        anchors.fill: view
        transparentBorder: true
        horizontalOffset: -4
        verticalOffset: 4
        radius: 8.0
        color: "#40000000"
        source: view
    }

    SwipeView {
        id: view
        currentIndex: 2
        anchors.fill: parent
        spacing: blockMargin

        NewBeat {
            author: "ogbigtoy"
            title: "TestTestTestTestTestTestTestTest"
            cover: "qrc:/png/temp/eat.jpg"
        }

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

//    PageIndicator {
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }
}
