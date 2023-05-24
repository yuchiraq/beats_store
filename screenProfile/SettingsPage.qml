import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Flickable {
    id: settingsPage

    width: parent

    anchors.fill: leftScreen
    anchors.topMargin: topBar.height + blockMargin
    anchors.bottomMargin: bottomBar.height

    contentHeight: settingsColumn.height

    Connections {
        target: setHost
    }

    Column {
        id: settingsColumn

        anchors {
            top: leftScreen.top
            topMargin: topBar.height + blockMargin
            bottomMargin: topBar.height
            horizontalCenter: parent.horizontalCenter
        }

        width: parent.width

        spacing: blockMargin

        Rectangle {
            id: themeSwitcher

            width: mainScreen.width - blockMargin * 2
            height: blockMargin * 5

            radius: blockMargin * 2

            color: container

            anchors.horizontalCenter: parent.horizontalCenter

            anchors.top: parent.top

            //anchors.topMargin: blockMargin * 2
            Text {
                font.family: appFont
                text: "Тёмная тема"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: blockMargin * 2
                color: secondary
                font.pointSize: 15
            }

            Switch {
                checked: mainScreen.darkTheme

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: blockMargin * 2

                onClicked: {
                    if (mainScreen.darkTheme) {
                        mainScreen.darkTheme = false
                        //darkest = "#FFF"
                        //dark = "#AAA"
                        //darkestTransparency = "#EFFFFFFF"
                    } else {
                        mainScreen.darkTheme = true
                        //dark = "#111"
                        //darkest = "#0D0C0D"
                        //darkestTransparency = "#810F0A0F"
                    }
                }
            }
        }

        Rectangle {
            id: deleteData

            width: mainScreen.width - blockMargin * 2
            height: blockMargin * 5

            radius: blockMargin * 2

            color: container

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: themeSwitcher.bottom
            anchors.topMargin: blockMargin * 2

            Text {
                font.family: appFont
                text: "Удалить данные"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: blockMargin * 2
                color: secondary
                font.pointSize: 15
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    database.deleteData()
                    centralScreen.update()
                }
            }
        }

        TextField {
            id: ipField

            anchors.top: deleteData.bottom
            anchors.topMargin: blockMargin
            anchors.horizontalCenter: parent.horizontalCenter

            font.family: appFont
            placeholderText: "IP server"
            font.pointSize: blockMargin * 2
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary
            onAccepted: {
                setHost.getHost(ipField.text)
                //ip = ipField.text
                startSplashScreen.startSplash()
            }
            background: Rectangle {
                anchors.centerIn: parent

                width: mainScreen.width - blockMargin * 2
                height: blockMargin * 5

                radius: blockMargin * 2
                color: ipField.activeFocus ? dark : outline

                border.width: ipField.activeFocus ? 1 : 0
                border.color: accent
            }
        }

        TextField {
            id: avaField

            anchors.top: ipField.bottom
            anchors.topMargin: blockMargin
            anchors.horizontalCenter: parent.horizontalCenter

            font.family: appFont
            placeholderText: "avatar's URL"
            font.pointSize: blockMargin * 2
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary

            onAccepted: {
                leftScreen.ava = avaField.text
            }
            background: Rectangle {
                anchors.centerIn: parent

                width: mainScreen.width - blockMargin * 2
                height: blockMargin * 5

                radius: blockMargin * 2
                color: outline
            }
        }

        Rectangle {
            id: testField
            anchors.top: avaField.bottom
            anchors.topMargin: blockMargin
            anchors.horizontalCenter: parent.horizontalCenter

            height: 80
            width: parent.width - blockMargin * 2
            color: "transparent"
            TextField {
                Material.theme: Material.Dark
                anchors.fill: parent
            }
        }

        Rectangle {
            id: testButton
            anchors.top: testField.bottom
            anchors.topMargin: blockMargin
            anchors.horizontalCenter: parent.horizontalCenter

            height: 80
            width: parent.width - blockMargin * 2
            radius: blockMargin
            color: "transparent"
            Button {
                Material.theme: Material.Dark
                anchors.fill: parent

                down: true

                onClicked: notification.start()
            }
        }
    }
}
