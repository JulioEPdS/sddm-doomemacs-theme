import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    height: 50
    width: 300

    model: sessionModel
    currentIndex: model.lastIndex
    textRole: "name"

    indicator.visible: false
    
    contentItem: Text {
        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.LoginFontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: "Session: " + parent.currentText
    }

    /*
    background: Rectangle {
        height: 50
        width: displayedItem.implicitWidth
        anchors.bottom: parent.top
        anchors.left: parent.left

        border.width: parent.visualFocus ? 1 : 0
        border.color: "black"
        color: "white"
    }
    */

    delegate: ItemDelegate {
        id: sessionEntry
        
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        
        contentItem: Text {
            renderType: Text.NativeRendering
            font.family: config.Font
            font.pointSize: config.LoginFontSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text: model.name
        }
        
        /*
        highlighted: parent.highlightedIndex === index
        background: Rectangle {
            color: parent.highlightedIndex === index ? "blue" : "white"
        }
        */
    }

    onActivated: print(currentIndex)
}
