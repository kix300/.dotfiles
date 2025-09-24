import QtQuick
import Quickshell.Io
import qs.services

Item {
    id: root
    width: 25
    height: 25

    Text {
        id: networkIcon
        anchors.centerIn: parent
        text: Network.icon
        color: Network.isEthernetConnected ? Colors.pine : Network.connected ? Colors.text : Colors.muted

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: {
                nmtuiProcess.running = true;
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.RightButton
            onClicked: {
                // networkIcon.color = Colors.love;
                nmtuiRescanProcess.running = true;
            }
        }
    }
    Process {
        id: nmtuiProcess
        command: ["ghostty", "-e", "nmtui"]
    }
    Process {
        id: nmtuiRescanProcess
        command: ["nmcli", "device", "wifi", "rescan"]
    }
}
