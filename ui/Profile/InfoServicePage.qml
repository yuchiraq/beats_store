import QtQuick 2.15
import QtQuick.Controls.Material

Flickable {
    id: infoService

    contentHeight: infoServiceColumn.height
    anchors.fill: parent

    //anchors.topMargin: topBar.height
    anchors.bottomMargin: bottomBar.height

    Column {

        id: infoServiceColumn

        anchors.fill: parent

        anchors.topMargin: topBar.height
        anchors.bottomMargin: bottomBar.height

        spacing: blockMargin

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 2

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "О нас"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "    OGBeats – сервис для приобретения лицензионной музыки. Оцени бит, "
                  + "послушай его и приобрети лицензию с документами, юридически подтверждающими "
                  + "твои права на использование музыки."

            color: light
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 2
            anchors.topMargin: blockMargin

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "Соглашение"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "    Уважаемый пользователь, внимательно ознакомьтесь с данным документом, прежде чем воспользоваться услугами OGBeats."
            + "\n  1. Настоящее пользовательское соглашение (далее «Соглашение») заключается между владельцем этого сайта (далее «Администрация сайта»),"
            + " с одной стороны, и пользователем данного сайта (далее «Пользователь»), с другой стороны."
            + "\n  2. Сайт OGBeats не относится к средствам массовой информации."
            + "\n  3. Начав использование сайта, Вы соглашаетесь с условиями данного Соглашения."
            + "\n  4. Соглашение может быть изменено по усмотрению Администрации сайта, без уведомления Пользователя."
            + "\n  5. Пользователь несет персональную ответственность за проверку настоящего Соглашения на наличие изменений в нем."
            + "\n  6. Если Вы не согласны с условиями Соглашения, просим Вас покинуть Сайт."

            color: light
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 2
            anchors.topMargin: blockMargin

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "Предмет соглашения"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "Предметом настоящего Соглашения является предоставление Пользователю доступа"
            + " к содержащейся на Сайте информации и оказываемым услугам."
            + "\n\nСайт предоставляет Пользователю следующие виды услуг (сервисов):"
            + "\n  • доступ к электронному контенту на основе, с правом приобретения (скачивания), просмотра контента;"
            + "\n  • доступ к средствам поиска и навигации Сайта;"
            + "\n  • предоставление Пользователю возможности размещения сообщений, комментариев, рецензий."
            + "\n  • доступ к информации об услугах.- иные виды услуг (сервисов), реализуемые на страницах Сайта."
            + "\n\nПод действие настоящего Соглашения подпадают все существующие (реально функционирующие) на данный момент услуги (сервисы) Сайта."

            color: light
        }


    }

}
