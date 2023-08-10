import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import SddmComponents 2.0

Rectangle {
    id: footer
    width: parent.width
    height: parent.height / 30

    anchors {
        bottom: parent.bottom
    }

    color: config.FooterBckgrndColor
    opacity: 1

    Row {
        id: footerRow
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.fill: parent


        Rectangle {
            id: leftRectangle
            width: parent.width / 300
            height: parent.height

//            anchors.bottom: parent.bottom

            color: config.FooterLeftRtnglColor
        }

        Rectangle {
            id: footerCircle
            color: config.FooterGreenColor
            width: 14
            height: 14
            radius: width * 0.5
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txt1
            color: config.FooterForeground
            font.family: config.Font//"FiraCode Nerd Font"
            font.pixelSize: config.FontSize//12
            text: "100"
            //leftPadding: 20.0
            anchors.verticalCenter: parent.verticalCenter
        }

        Row {
            id: hostnameRow
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txt2
                font.bold: true
                color: config.FooterGreenColor
                font.family: config.Font
                font.pixelSize: config.FontSize
                text: "sddmLogin/" //+ sddm.hostName + ("/doomOne.qml")
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: txt3
                font.bold:true
                color: config.FooterWhiteColor
                font.family: config.Font
                font.pixelSize: config.FontSize
                text: qsTr (sddm.hostName) + ("/doomOne.qml")
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: txt4
            color: config.FooterForeground
            font.family: config.Font
            font.pixelSize: config.FontSize
            text: "50:50 25%"
            //leftPadding: 20.0
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    Text {
        id: txt5
        font.bold: true
        color: config.FooterBlueColor
        font.family: config.Font
        font.pixelSize: config.FontSize
        text: "Arch/Linux"
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        rightPadding: 10
    }
}
