import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Item {
    property var user: userPanel.username
    property var password: passwordField.text
    property var session: sessionPanel.session
    property var inputHeight: Screen.height * config.UIScale * 0.25
    property var inputWidth: Screen.width * config.UIScale

    Column {
        spacing: 8
        width: inputWidth

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }

        UserPanel {
            id: userPanel
        }

        PasswordPanel {
            id: passwordField

            height: inputHeight
            width: parent.width
            onAccepted: loginButton.clicked()
        }

        Button {
            id: loginButton

            height: inputHeight
            width: parent.width
            enabled: user != "" && password != "" ? true : false
            hoverEnabled: true
            onClicked: {
                sddm.login(user, password, session);
            }
            states: [
                State {
                    name: "pressed"
                    when: loginButton.down

                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(config.LoginButtonBg, 1.4)
                        opacity: 1
                    }

                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }

                },
                State {
                    name: "hovered"
                    when: loginButton.hovered

                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(config.LoginButtonBg, 1.2)
                        opacity: 1
                    }

                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }

                },
                State {
                    name: "enabled"
                    when: loginButton.enabled

                    PropertyChanges {
                        target: buttonBackground
                        opacity: 1
                    }

                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }

                }
            ]

            Rectangle {
                id: loginAnim

                radius: parent.width / 2
                anchors.centerIn: loginButton
                color: "black"
                opacity: 1

                NumberAnimation {
                    id: coverScreen

                    target: loginAnim
                    properties: "height, width"
                    from: 0
                    to: root.width * 2
                    duration: 1000
                    easing.type: Easing.InExpo
                }

            }

            contentItem: Text {
                id: buttonText

                renderType: Text.NativeRendering
                font.family: config.Font
                font.pointSize: config.FontSize
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: config.LoginButtonTextColor
                opacity: 0.5
                text: config.LoginButtonText
            }

            background: Rectangle {
                id: buttonBackground

                color: config.LoginButtonBg
                opacity: 0.5
                radius: config.Radius
            }

            transitions: Transition {
                PropertyAnimation {
                    properties: "color, opacity"
                    duration: 150
                }

            }

        }

        Row {
            spacing: 8
            //Removed since the column + row is enough
            /*anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.08
                left: parent.left
            }*/
            PowerPanel {
                id: powerPanel
            }
            SessionPanel {
                id: sessionPanel
            }
        }
    }

    Connections {
        function onLoginSucceeded() {
            coverScreen.start();
        }

        function onLoginFailed() {
            passwordField.text = "";
            passwordField.focus = true;
        }

        target: sddm
    }

}
