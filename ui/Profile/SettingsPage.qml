import QtQuick 2.15
import QtQuick.Controls.Material

Flickable {
    id: settingsPage

    width: parent

    anchors.fill: leftScreen
    anchors.topMargin: topBar.height + blockMargin
    anchors.bottomMargin: bottomBar.height

    contentHeight: settingsColumn.height

    property bool darkTheme: true

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

            width: mainScreen.width - blockMargin * 2
            height: blockMargin * 5

            radius: blockMargin * 2

            color: dark

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: blockMargin * 2

            Text {
                font.family: appFont
                text: "Тёмная тема"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: blockMargin * 2
                color: secondary
            }

            Switch {
                checked: true

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: blockMargin * 2

                onClicked: {
                    if(!checked){
                        darkTheme = false
                        darkest = "#FFF"
                        dark = "#171717"
                        darkestTransparency = "#EFFFFFFF"
                    } else {
                        darkTheme = true
                        dark: "#1C1B1F"
                        darkest: "#171717"
                        darkestTransparency: "#EF171717"
                    }
                }

            }

        }
    }

}
