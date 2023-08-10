import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "components"

Item {
    id: root

    height: Screen.height
    width: Screen.width

    Image {
        id: background

        anchors.fill: parent
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop
        source: config.Background
        asynchronous: false
        cache: true
        mipmap: true
        clip: true
    }

    Column {
        id: contentRow
        spacing: 10

        width: parent.width * 0.9
        height: parent.height * 0.9

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        /*anchors {
            fill: parent
            //topMargin: parent.height * 0.08
            //rightMargin: config.Padding
            //bottomMargin: config.Padding
            //leftMargin: parent.width * 0.07
        }*/

        DateTimePanel {
            id: dateTimePanel

            anchors {
                top: parent.top
                left: parent.left
            }

        }

        LoginPanel {
            id: loginPanel

            anchors.fill: parent
        }

    }

    Footer {
        id: footer
        anchors.bottom: parent.bottom
    }
}
