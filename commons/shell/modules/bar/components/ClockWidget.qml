// ClockWidget.qml
import QtQuick
import "utils"
import qs.services

Rectangle {
    id: container
    color: Colors.surface
    width: 175
    radius: 12
    height: 25
    border.color: Colors.withOpacity(Colors.overlay, 0.3)
    border.width: 1
    Text {
        color: Colors.text
        text: Time.time
        anchors.centerIn: parent
        font.pixelSize: 15
        font.weight: Font.Medium
    }
}
