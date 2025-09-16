import QtQuick
import QtQuick.Layouts
import qs.services

Item {
    id: root
    width: 25
    height: 25

    Text {
        id: brightnessIcon
        anchors.centerIn: parent
        color: Colors.text
        text: Light.getBrightnessIcon()
    }
}
