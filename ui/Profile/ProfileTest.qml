import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"

Flickable {
    id: leftScreen

    contentHeight: profileColumn.height
    anchors.fill: parent
    anchors.topMargin: topLogo.height
    anchors.bottomMargin: bottomBar.height

    Column {
        id: profileColumn

        anchors {
            top: mainScreen.top
            topMargin: topLogo.height
            bottomMargin: topLogo.height
            horizontalCenter: parent.horizontalCenter
        }

        spacing: blockMargin

        Rectangle {
            width: mainScreen.width - (blockMargin * 2)
            height: width / 2 * 1

            color: dark

            radius: width / 20

            Rectangle {
                id: avaMask
                width: parent.height
                height: width
                color: darkVariant
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                radius: parent.radius
            }

            HeaderTextStyle {
                text: "Account Name"
                anchors.left: avaMask.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: blockMargin * 2
                color: "white"
            }
        }

        Rectangle {
            id: profileMenu

            width: mainScreen.width - blockMargin * 2
            height: blockMargin * 6 * 3 + 2

            anchors.horizontalCenter: parent.horizontalCenter

            radius: width / 20

            color: dark

            Column {
                anchors.fill: parent

                spacing: 0
                Button {
                    width: parent.width
                    height: blockMargin * 6

                    background: Rectangle {
                        color: "#00000000"
                    }

                    BasicTextStyle {
                        text: "шото"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
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
                    height: blockMargin * 6

                    background: Rectangle {
                        color: dark
                    }

                    BasicTextStyle {
                        text: "шото"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
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
                    height: blockMargin * 6

                    background: Rectangle {
                        color: "#00000000"
                    }

                    BasicTextStyle {
                        text: "Выход"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                        color: "#F00"
                    }

                    onClicked: {
                        mainScreen.close()
                        mainScreen.destroy()
                    }

                }

            }

        }

        ProgressBar {
            indeterminate: true
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
