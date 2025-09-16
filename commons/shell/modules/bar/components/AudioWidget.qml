import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.services

Item {
    id: root
    width: 25
    height: 25

    Row {
        anchors.centerIn: parent
        spacing: 4

        Text {
            id: audioIcon
            anchors.verticalCenter: parent.verticalCenter
            color: Colors.text
            text: Audio.getVolumeIcon() + " " + Audio.getDeviceIcon()

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    pavucontrolProcess.running = true;
                }
            }
        }
    }

    Process {
        id: pavucontrolProcess
        command: ["pavucontrol"]
    }
}
