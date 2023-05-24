import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "../cards"

Rectangle {
    id: styleChooser
    anchors.fill: parent
    color: "transparent"

    property int styleFor: 0

    //randomBeats : 1
    //randomAuthors : 2
    //randomAlbums : 3
    //lastRealises : 4
    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            stackMaskedBackground.visible = false
            parent.visible = false
        }
    }

    //    DropShadow {
    //        anchors.fill: styleChooserBlock
    //        transparentBorder: true
    //        horizontalOffset: 0
    //        verticalOffset: -12
    //        radius: 12.0
    //        color: "#40000000"
    //        source: styleChooserBlock
    //    }
    Rectangle {
        id: styleChooserBlock

        width: mainScreen.width - blockMargin
        height: parent.height * 0.5

        //height: 0
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        radius: blockMargin * 2

        color: surface

        border.color: outline
        border.width: 0.5

        //Material.theme: Material.Dark
        MouseArea {
            anchors.fill: parent
            signal sgSwipeLeft
            signal sgSwipeRight
            signal sgSwipeDown
            signal sgSwipeUp

            QtObject {

                property bool pTracing: false
                property real pXVelocity: 0.0
                property real pYVelocity: 0.0
                property int pXPrev: 0
                property int pYPrev: 0

                id: oPrivate
            }

            id: oRoot
            preventStealing: true

            onPressed: {

                oPrivate.pTracing = true
                oPrivate.pXVelocity = 0
                oPrivate.pYVelocity = 0
                oPrivate.pXPrev = mouse.x
                oPrivate.pYPrev = mouse.y
            }

            onPositionChanged: {

                if (!oPrivate.pTracing)
                    return

                var oCurrentXVelocity = (mouse.x - oPrivate.pXPrev)
                oPrivate.pXVelocity = (oPrivate.pXVelocity + oCurrentXVelocity) / 2.0
                oPrivate.pXPrev = mouse.x

                var oCurrentYVelocity = (mouse.y - oPrivate.pYPrev)
                oPrivate.pYVelocity = (oPrivate.pXVelocity + oCurrentYVelocity) / 2.0
                oPrivate.pYPrev = mouse.y

                if (oPrivate.pXVelocity > 15 && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeRight()
                } else if (oPrivate.pXVelocity < -15
                           && mouse.x > parent.width * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeLeft()
                } else if (oPrivate.pYVelocity > 2
                           && mouse.y > parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeDown()
                } else if (oPrivate.pYVelocity < -15
                           && mouse.y < parent.height * 0.2) {
                    oPrivate.pTracing = false
                    oRoot.sgSwipeUp()
                }
            }

            onClicked: console.log("onClicked")
            onPressAndHold: console.log("onPressAndHold")
            onSgSwipeLeft: console.log("onSgSwipeLeft")
            onSgSwipeDown: {
                stackMaskedBackground.visible = false
                styleChooser.visible = false
                console.log("onSgSwipeDown")
            }
            onSgSwipeRight: console.log("onSgSwipeRight")
            onSgSwipeUp: console.log("onSgSwipeUp")
            onReleased: console.log("onReleased")
        }

        Rectangle {
            id: styleChooserMaskSource
            width: parent.width
            height: parent.height * 3 / 4
            anchors {
                top: styleChooserHeaderTitle.bottom
                topMargin: blockMargin
                bottom: parent.bottom
                bottomMargin: blockMargin / 2
                horizontalCenter: parent.horizontalCenter
            }

            color: surface
            Flickable {

                anchors.fill: styleChooserMaskSource
                clip: true

                //contentHeight: tester.height * 20
                Column {
                    anchors.fill: parent

                    Button {
                        width: parent.width
                        height: blockMargin * 5
                        Text {
                            font.family: appFont
                            text: "Сначала старые"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 2
                            color: secondary
                            font.pointSize: blockMargin * 2
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: alert
                                anchors.fill: parent
                            }
                        }
                        background: Rectangle {
                            anchors.fill: parent
                            color: surface
                        }
                        onClicked: {
                            if (styleFor == 4) {
                                centralScreen.lastSortBy = 0
                                styleChooser.visible = false
                                centralScreen.update()
                                centralScreen.lastRealisesText = "Сначала старые"
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width - blockMargin * 2
                        height: 0.5
                        color: outline
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        Text {
                            font.family: appFont
                            text: "Сначала новые"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 2
                            color: secondary
                            font.pointSize: blockMargin * 2
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: alert
                                anchors.fill: parent
                            }
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: surface
                        }
                        onClicked: {
                            if (styleFor == 4) {
                                centralScreen.lastSortBy = 1
                                styleChooser.visible = false
                                centralScreen.update()
                                centralScreen.lastRealisesText = "Сначала новые"
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width - blockMargin * 2
                        height: 0.5
                        color: outline
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        Text {
                            font.family: appFont
                            text: "По названию"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 2
                            color: secondary
                            font.pointSize: blockMargin * 2
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin * 2

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: alert
                                anchors.fill: parent
                            }
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: surface
                        }
                        onClicked: {
                            if (styleFor == 4) {
                                centralScreen.lastSortBy = 2
                                styleChooser.visible = false
                                centralScreen.update()
                                centralScreen.lastRealisesText = "По названию"
                            }
                        }
                    }
                }
            }
        }

        Text {
            id: styleChooserHeaderTitle
            text: "Error!!!\nclose this!"

            width: parent.width * 2 / 3
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: topLineStyleChooser.bottom
                topMargin: blockMargin
            }

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: blockMargin * 2
            font.family: appFont
            font.bold: true
            wrapMode: Label.Wrap
            color: accent
        }

        Rectangle {
            color: outline
            width: parent.width
            height: 0.5
            anchors.bottom: styleChooserMaskSource.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Rectangle {
            id: topLineStyleChooser

            width: 40
            height: 4

            color: accent

            radius: 2

            anchors {
                top: parent.top
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function starter() {
        if (styleFor == 4) {
            styleChooserHeaderTitle.text = "Выберите сортировку для последних релизов"
        } else {
            styleChooserHeaderTitle.text = "Error!\nClose this"
        }

        stackMaskedBackground.visible = true
        styleChooser.visible = true
        //beatFunctionsOpen.running = true
    }
}
