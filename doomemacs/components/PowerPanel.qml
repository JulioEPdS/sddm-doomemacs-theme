import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    implicitHeight: powerButton.height
    implicitWidth: powerButton.width

    ListModel {
        id: powerModel

        ListElement {
            name: "Sleep"
        }

        ListElement {
            name: "Restart"
        }

        ListElement {
            name: "Shut\nDown"
        }

    }

    Button {
        id: powerButton

        height: inputHeight
        width: inputHeight * 2
        hoverEnabled: true
        icon.source: Qt.resolvedUrl("../icons/power.svg")
        icon.height: height
        icon.width: width
        icon.color: config.PowerIconColor
        onClicked: {
            powerPopup.visible ? powerPopup.close() : powerPopup.open();
            powerButton.state = "pressed";
        }
        states: [
            State {
                name: "pressed"
                when: powerButton.down

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonBg, 1.2)
                }

            },
            State {
                name: "hovered"
                when: powerButton.hovered

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonBg, 1.2)
                }

            },
            State {
                name: "selection"
                when: powerPopup.visible

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonBg, 1.2)
                }

            }
        ]

        background: Rectangle {
            id: powerButtonBg

            color: config.PowerButtonBg
            radius: config.Radius
        }

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }

        }

    }

    Popup {
        id: powerPopup

        height: inputHeight * 0.9 + padding * 2
        //x: powerButton.width + powerList.spacing
        y: powerButton.height * 1.3
        padding: 9

        background: Rectangle {
            radius: config.Radius * 1.8
            color: config.PopupBackground
        }

        contentItem: ListView {
            id: powerList

            implicitWidth: contentWidth
            spacing: 9
            orientation: Qt.Horizontal
            clip: true
            model: powerModel

            delegate: ItemDelegate {
                id: powerEntry

                height: inputHeight * 0.9
                width: inputHeight * 0.9
                display: AbstractButton.TextUnderIcon
                states: [
                    State {
                        name: "hovered"
                        when: powerEntry.hovered

                        PropertyChanges {
                            target: powerEntryBg
                            color: Qt.lighter(config.PopupHighlight, 1.2)
                        }

                        PropertyChanges {
                            target: powerIcon //iconOverlay
                            color: Qt.darker(config.PopupHighlight, 1.2)
                        }

                    }
                ]

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        powerPopup.close();
                        index == 0 ? sddm.suspend() : (index == 1 ? sddm.reboot() : sddm.powerOff());
                    }
                }

                contentItem: Item {
                    Image {
                        id: powerIcon

                        anchors.centerIn: parent
                        source: index == 0 ? Qt.resolvedUrl("../icons/sleep.svg") : (index == 1 ? Qt.resolvedUrl("../icons/restart.svg") : Qt.resolvedUrl("../icons/power.svg"))
                        sourceSize: Qt.size(powerEntry.width * 0.5, powerEntry.height * 0.5)
                    }

                    ColorOverlay {
                        id: iconOverlay

                        anchors.fill: powerIcon
                        source: powerIcon
                        color: config.PopupBackground
                    }


                }

                background: Rectangle {
                    id: powerEntryBg

                    color: config.PopupHighlight
                    radius: config.Radius
                }

                transitions: Transition {
                    PropertyAnimation {
                        properties: "color, opacity"
                        duration: 150
                    }

                }

            }

        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 300
                    easing.type: Easing.OutExpo
                }

                NumberAnimation {
                    property: "y"
                    from: powerPopup.y - (inputWidth * 0.1)
                    to: powerPopup.y
                    duration: 400
                    easing.type: Easing.OutExpo
                }

            }

        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 400
                easing.type: Easing.OutExpo
            }

        }

    }

}
