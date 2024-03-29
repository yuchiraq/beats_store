import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"

Item {
    id: blockNewRealise

    width: mainScreen.width - blockMargin * 2
    height: width / 2 * 1

    anchors {
        leftMargin: blockMargin
        rightMargin: blockMargin
    }

    SwipeView {
        id: view
        currentIndex: 2
        anchors.fill: parent
        spacing: blockMargin

        NewBeat {
            author: "ogbigtoy"
            title: "TestTestTestTestTestTestTestTest"
            cover: "http://" + ip + "/newRealises/" + "1" + ".jpg"
        }

        NewBeat {
            author: "Niki-Y On Da Track"
            title: "«CLASSIC PACK III»"
            cover: "http://" + ip + "/newRealises/" + "3" + ".jpg"
        }

        NewBeat {
            author: "Niki-Y On Da Track"
            title: "«162 pack 3»"
            cover: "http://" + ip + "/newRealises/" + "4" + ".jpg"
            Component.onCompleted: console.log("created:")
            Component.onDestruction: console.log("destroyed:")
        }

        NewBeat {
            id: test
            author: "Niki-Y On Da Track"
            title: "«162 pack 2»"
            cover: "http://" + ip + "/newRealises/" + "6" + ".jpg"
            Component.onCompleted: console.log("created:")
            Component.onDestruction: console.log("destroyed:")
        }
        Repeater {
            model: 60
            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem
                        || SwipeView.isPreviousItem
                sourceComponent: NewBeat {
                    Component.onCompleted: console.log("created:", index)
                    Component.onDestruction: console.log("destroyed:", index)
                }
            }
        }
    }
}
